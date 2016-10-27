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

        syncViewModel()

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

        getPost(withId: self.postId!)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editPostSegue" {
            let nextVC = segue.destination as? NewPostViewController

            nextVC?.editingPost = decode(dictionaryInPost: self.model!)
            nextVC?.isNewPost = false
        }
    }

    // MARK: - Utils
    func getPost(withId id: String) {

        client.invokeAPI("getPost",
                         body: nil,
                         httpMethod: "GET",
                         parameters: ["id": id],
                         headers: nil) { (result, response, error) in
                            if error != nil {
                                return print("💥⛈💔Error recuperando post con id: \(error)")
                            }
                            print("💥⛈💔resultado\(result)")

                            if let posts = result {

                                let JSONDicts = posts as! [JSONDictionary]
                                let postDict = JSONDicts[0]
                                do {
                                    let post = try decode(postInDictionary: postDict )

                                    self.model = post

                                    self.syncViewModel()
                                } catch {
                                    return print("💥⛈💔error creando Post:\(error)")
                                }
                            }
        }
    }
    func syncViewModel() {
        titleLable.text = model?.title
        photoView.image = model?.photo
        authorLabel.text = model?.author
        dateLabel.text = model?.date
        bodyLabel.text = model?.body
        // TODO: - score
        // location
    }
}
