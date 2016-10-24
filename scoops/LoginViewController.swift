//
//  ViewController.swift
//  scoops
//
//  Created by Edu González on 22/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "folderTableSegue" {

            let nextVC = segue.destination as? FolderTableViewController

            let folder = Folder.init()
            nextVC?.model = folder
        }
    }




}

