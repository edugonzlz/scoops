//
//  NewPostViewController.swift
//  scoops
//
//  Created by Edu González on 24/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Properties
    var model: Post?
    var container: AZSCloudBlobContainer?
    var editingPost = [String : Any]()
    var isNewPost: Bool?

    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    @IBOutlet weak var makePostPublicSwitch: UISwitch!
    @IBOutlet weak var photoView: UIImageView!

    // MARK: - Actions
    @IBAction func savePostButton(_ sender: UIBarButtonItem) {
        if isNewPost! {
            savePost()
            insertInAzure(post: self.editingPost)
        }
        if !(isNewPost!) {
            savePost()
            updateInAzure(post: self.editingPost)
        }
    }
    @IBAction func addPhotoButton(_ sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }

    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        syncModelView()
        // accedemos a nuestro container para guardar fotos
        self.container = accessContainer(withName: containerName)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        //Añadimos boton para ocultar teclado
        let helpBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.bodyTextField.frame.width, height: 44))
        let okButton = UIBarButtonItem(title: "OK",
                                       style: .plain,
                                       target: self,
                                       action: #selector(hideKeyboard))
        helpBar.setItems([okButton], animated: true)
        self.titleTextField.inputAccessoryView = helpBar
        self.bodyTextField.inputAccessoryView = helpBar
    }

    // MARK: - Azure
    func savePost() {
        if self.titleTextField.text == "" || self.bodyTextField.text == "" {
            self.fieldsEmptyAlert()

        } else {
            guard let title = self.titleTextField.text,
                let body = self.bodyTextField.text else {
                    return print("💥⛈💔No existen los campos")
            }

            // subimos la imagen al Storage
            let name = title + UUID().uuidString
            uploadBlob(toContainer: self.container, withImage: self.photoView.image!, withName: name)
            // obtenemos URL y guardamos en editingPost
            let blobURL = URL(string: storageURL)?.appendingPathComponent((self.container!.name)).appendingPathComponent(name)

            editingPost[titleKEY] = title
            editingPost[bodyKEY] = body
            editingPost[authorKEY] = "Edu"
            editingPost[photoURLKEY] = blobURL?.absoluteString
            editingPost[latitudeKEY] = 5
            editingPost[longitudeKEY] = 5
            editingPost[publicatedKEY] = self.makePostPublicSwitch.isOn
            editingPost[userIdKey] = userId()
        }
        hideKeyboard()
    }
    func insertInAzure(post: [String: Any]) {
        let table = client.table(withName: postsTableKey)

        table.insert(post) { (results, error) in
            if error != nil {
                return print("💥⛈💔Error insertando post: \(error)")
            }
            print("💥⛈💔Post insertado:\(results)")
            self.saveAlert()
        }
    }
    func updateInAzure(post: [String: Any]) {

        let table = client.table(withName: postsTableKey)

        table.update(post) { (results, error) in
            if error != nil {
                return print("💥⛈💔Error actualizando post: \(error)")
            }
            print("💥⛈💔Post actualizado:\(results)")
            self.saveAlert()
            // Notificamos de la actualizacion en azure para actualizar la vista de detalle
            let nc = NotificationCenter.default
            let notif = Notification(name: Notification.Name(rawValue: postUpdated))
            nc.post(notif)
        }
    }

    // MARK: - Utils
    func syncModelView() {

        self.titleTextField.text = self.editingPost[titleKEY] as? String
        self.bodyTextField.text = self.editingPost[bodyKEY] as? String
        if !(isNewPost!) {
            self.makePostPublicSwitch.isOn = self.editingPost[publicatedKEY] as! Bool
            self.photoView.image = self.model?.photo
        }
    }
    func hideKeyboard() {
        self.bodyTextField.resignFirstResponder()
    }
    func saveAlert() {
        let alert = UIAlertController(title: nil,
                                      message: "Post Saved",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func fieldsEmptyAlert() {
        let alert = UIAlertController(title: nil,
                                      message: "Title and Body necessary to save",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    // MARK: - UIImagePickerViewDelegate
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {

        let image = info[UIImagePickerControllerOriginalImage]
        self.photoView.image = image as! UIImage?

        self.dismiss(animated: true, completion: nil)
    }
}
