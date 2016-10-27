//
//  NewPostViewController.swift
//  scoops
//
//  Created by Edu González on 24/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController {

    // MARK: - Properties
    var editingPost = [String : Any]()

    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!

    @IBOutlet weak var makePostPublicSwitch: UISwitch!
    // MARK: - Actions
    @IBAction func savePostButton(_ sender: UIBarButtonItem) {

        savePost()
    }

    @IBAction func addPhotoButton(_ sender: UIBarButtonItem) {

    }
    @IBAction func makePostPublicSwitch(_ sender: UISwitch) {
    }

    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()

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
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)

        // solo insertamos si los campos no estan vacios
        if self.titleTextField.text != "" && self.bodyTextField.text != "" {
            savePost()
            insertInAzure(post: self.editingPost)
        }
    }

    func savePost() {
        if self.titleTextField.text == "" || self.bodyTextField.text == "" {

            let alert = UIAlertController(title: nil,
                                          message: "Title and Body necessary to save",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)

        } else {

            guard let title = self.titleTextField.text,
                let body = self.bodyTextField.text else {
                    return print("💥⛈💔No existen los campos")
            }
            editingPost = [titleKEY: title,
                           bodyKEY: body,
                           authorKEY: "Edu",
                           photoURLKEY: "https://idoitta.files.wordpress.com/2012/05/perro-disfrazado-oveja-490x406.jpg",
                           latitudeKEY: 5,
                           longitudeKEY: 5,
                           publicatedKEY: self.makePostPublicSwitch.isOn,
                           scoreKEY:5]
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
        }
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

    // MARK: - Utils
    func hideKeyboard() {
//        self.view.endEditing(YES)
        self.bodyTextField.resignFirstResponder()
    }
}
