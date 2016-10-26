//
//  FrontViewController.swift
//  scoops
//
//  Created by Edu González on 24/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import UIKit

class FrontViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!

    @IBAction func loginWithFacebookButton(_ sender: UIButton) {
        loginWithFacebook()
    }
    @IBAction func noLoginButton(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if isUserAuth() {

            self.performSegue(withIdentifier: "folderTableSegue", sender: self)
        }
    }

    func loginWithFacebook() {
        client.login(withProvider: facebookProvider,
                     parameters: nil,
                     controller: self,
                     animated: true) { (user, error) in

                        if error != nil {
                            return print("Error en el login con facebook:\(error)")
                        }
                        if user != nil {

                            saveFacebookUserInfo(user: user!)

                            self.performSegue(withIdentifier: "folderTableSegue", sender: self.loginButton)
                        }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "folderTableSegue" {

//            let nextVC = segue.destination as? FolderTableViewController
//
//            let folder = Folder.init()
//            nextVC?.model = folder
        }
    }

}
