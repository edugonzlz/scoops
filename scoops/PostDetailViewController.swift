//
//  PostDetailViewController.swift
//  scoops
//
//  Created by Edu González on 26/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {

    // MARK: - Properties
    var model: Post?
    var postId: String?
    let nc = NotificationCenter.default

    // MARK: - Outlets
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var ratingValueLabel: UILabel!

    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var editPostButton: UIBarButtonItem!

    // MARK: - Actions
    @IBAction func ratingSlider(_ sender: UISlider) {
    }
    @IBAction func editPostButton(_ sender: AnyObject) {

        self.performSegue(withIdentifier: "editPostSegue", sender: self)
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // desactivamos el boton de edicion hasta que se descarga el post
        self.editPostButton.isEnabled = false
        getPost()

        // Ocultamos o mostramos el boton de edicion segun estemos logeados
        if !(isUserAuth()) {
            self.navigationItem.rightBarButtonItem = nil
        } else {
            self.navigationItem.rightBarButtonItem = self.editPostButton
            // Ocultamos el slider de rating para usuarios logeados
            self.ratingSlider.isHidden = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        nc.addObserver(self,
                       selector: #selector(getPost),
                       name: Notification.Name(rawValue: postUpdated),
                       object: nil)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)

        nc.removeObserver(self)

        sendRating()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editPostSegue" {
            let nextVC = segue.destination as? NewPostViewController

            nextVC?.model = self.model
            nextVC?.editingPost = decode(dictionaryInPost: self.model!)
            nextVC?.isNewPost = false
        }
    }

    // MARK: - Utils
    func getPost() {
        client.invokeAPI("getPost",
                         body: nil,
                         httpMethod: "GET",
                         parameters: ["id": self.postId!],
                         headers: nil) { (result, response, error) in
                            if error != nil {
                                return print("💥⛈💔Error recuperando post con id: \(error)")
                            }
                            print("💥⛈💔Recuperado post con id\(result)")

                            if let posts = result {

                                let JSONDicts = posts as! [JSONDictionary]
                                let postDict = JSONDicts[0]
                                do {
                                    let post = try decode(postInDictionary: postDict)

                                    self.model = post

                                    self.syncViewModel()
                                } catch {
                                    return print("💥⛈💔error creando Post:\(error)")
                                }
                            }
        }
    }
    func syncViewModel() {

        // activamos
        self.editPostButton.isEnabled = true

        titleLable.text = model?.title
        photoView.image = model?.photo
        authorLabel.text = model?.author
        dateLabel.text = model?.date
        bodyLabel.text = model?.body
        if let score = model?.score {
            if score < 0 {
                ratingValueLabel.text = "-"
            } else {
                ratingValueLabel.text = String(score)
            }
        }
        // location
    }
    func sendRating() {
        client.invokeAPI("postRatingPost",
                         body: nil,
                         httpMethod: "PUT",
                         parameters: ["id":self.postId!, "rating":self.ratingSlider.value],
                         headers: nil) { (result, response, error) in

                            if error != nil {
                                return print("💥⛈💔Error enviando rating:\(error)")
                            }
                            print("💥⛈💔Enviado Rating:\(error)")
        }

    }
}
