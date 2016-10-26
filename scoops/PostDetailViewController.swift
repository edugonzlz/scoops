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
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLable.text = model!.title
        photoView.image = model?.photo
        authorLabel.text = model?.author
        dateLabel.text = model?.date
        bodyLabel.text = model?.body
        // TODO: - score
        // location

        // Ocultamos o mostramos el boton de edicion segun estemos logeados
        if !(isUserAuth()) {
            self.navigationItem.rightBarButtonItem = nil
        } else {
            self.navigationItem.rightBarButtonItem = self.editPostButton
            // Ocultamos el slider de rating para usuarios logeados
            self.ratingSlider.isHidden = true
        }
    }
}
