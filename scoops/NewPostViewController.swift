//
//  NewPostViewController.swift
//  scoops
//
//  Created by Edu González on 24/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!

    // MARK: - Actions
    @IBAction func savePostButton(_ sender: UIBarButtonItem) {

        savePost()
    }
    
    @IBAction func addPhotoButton(_ sender: UIBarButtonItem) {

    }

    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)

    }

    func savePost() {
        if self.titleTextField.text == "" ||
            self.bodyTextField.text == "" {

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

                    return print("No existen los campos")
            }
            let post = ["title": title,
                        "body": body,
                        "author": "Edu",
                        "photoURL": "http://www.sowood.es",
                        "latitude": 5,
                        "longitude": 5,
                        "publicated": false,
                        "score": 3,
                        "creationDate":1232342342] as [String : Any]

            let table = client.table(withName: postsTableKey)

            table.insert(post) { (results, error) in
                if error != nil {
                    return print("Error insertando post: \(error)")
                }
                print("Post insertado:\(results)")
            }
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
    
}
