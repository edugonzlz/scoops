//
//  PostDetailViewController.swift
//  scoops
//
//  Created by Edu González on 26/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {

    var model: Post?

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var ratingValueLabel: UILabel!
    
    @IBAction func ratingSlider(_ sender: UISlider) {
    }
    @IBOutlet weak var editPostButton: UIBarButtonItem!
    @IBAction func editPostButton(_ sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLable.text = model!.title
        photoView.image = model?.photo
        authorLabel.text = model?.author
        dateLabel.text = model?.date
        bodyLabel.text = model?.body
        // TODO: - score
        // location

        if !(isUserAuth()) {
            self.navigationItem.rightBarButtonItem = nil
        } else {
            self.navigationItem.rightBarButtonItem = self.editPostButton
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
