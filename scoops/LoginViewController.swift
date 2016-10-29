//
//  LoginViewController.swift
//  scoops
//
//  Created by Edu González on 26/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!

    @IBAction func loginWithFacebookButton(_ sender: UIButton) {
        loginWithFacebook()
    }
    @IBAction func noLoginButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func loginWithFacebook() {
        client.login(withProvider: facebookProvider,
                     parameters: nil,
                     controller: self,
                     animated: true) { (user, error) in

                        if error != nil {
                            return print("💥⛈💔Error en el login con facebook:\(error)")
                        }
                        if user != nil {
                            saveFacebookUserInfo(user: user!)
                            self.dismiss(animated: true, completion: nil)
                        }
        }
    }
}
