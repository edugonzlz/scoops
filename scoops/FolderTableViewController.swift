//
//  FolderTableViewController.swift
//  scoops
//
//  Created by Edu González on 24/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import UIKit

class FolderTableViewController: UITableViewController {

    // MARK: - Properties
    var model = Folder()
    let nc = NotificationCenter.default

    // MARK: - Outlets
    @IBOutlet weak var loginButton: UIBarButtonItem!

    // MARK: - Actions
    @IBAction func loginButton(_ sender: UIBarButtonItem) {
        if !(isUserAuth()) {
            presentLoginViewController()
        }
        if isUserAuth() {
            logout()
        }

    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        syncWithModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        // cuando recibimos notificacion del cambio en el modelo resincronizamos la tabla
        nc.addObserver(self,
                       selector: #selector(syncWithModel),
                       name: NSNotification.Name(rawValue: getAllPostsNotification),
                       object: nil)
        // despues de suscribirnos pedimos que descarguen los datos
        self.model.readAllPostsFromAzureWithApi()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)

        nc.removeObserver(self)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.model.numberOfSections()
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Cuando la seccion private esta vacia no aparece en la tabla
        if section == 0 && self.model.postCount(forSection: section) == 0 {
            return nil
        }
        return self.model.sectionName(forSection: section)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.postCount(forSection: section)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = self.model.post(forIndexPath: indexPath)

        let cellID = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)

        cell?.textLabel?.text = post.title
        cell?.detailTextLabel?.text = post.author

        return cell!
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postDetailSegue" {
            let path = self.tableView.indexPathForSelectedRow
            let post = self.model.post(forIndexPath: path!)

            let nextVC = segue.destination as? PostDetailViewController
            nextVC?.postId = post.id
        }
        if segue.identifier == "newPostSegue" {
            let nextVC = segue.destination as? NewPostViewController
            nextVC?.isNewPost = true
        }
    }

    // MARK: - Utils
    func syncWithModel() {
        self.tableView.reloadData()

        // Ocultamos o mostramos el boton de creacion de post segun estemos logeados
        if !(isUserAuth()) {
            self.navigationItem.rightBarButtonItems = []
            self.loginButton.title = "Login"
        }
        if isUserAuth() {
            let addPostButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushNewPost))
            self.navigationItem.rightBarButtonItem = addPostButton
            self.loginButton.title = "Logout"
            // si el usuario esta logueado creamos su container para almacenar fotos
            setupStorage()
        }
    }
    func pushNewPost() {
//        self.navigationItem.backBarButtonItem?.title = "Cancel"
        performSegue(withIdentifier: "newPostSegue", sender: self)
    }

    func setupStorage() {
        setupAzureClient()
        // Creamos un container para nuestro usuario
        //Deberiamos crear un container con un nombre unico
        newContainer(withName: containerName)
    }
    func presentLoginViewController() {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginModal")
        loginVC?.modalPresentationStyle = .pageSheet
        loginVC?.modalTransitionStyle = .flipHorizontal
        present(loginVC!, animated: true, completion: nil)
    }
    func logout() {
        let alert = UIAlertController(title: nil, message: "Are you sure to Logout?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "YES", style: .destructive) { (alert: UIAlertAction!) in
            client.logout { (error) in
                if error != nil {
                    return print("💥⛈💔Error en el logout")
                }
                removeFacebookUserInfo()
                self.syncWithModel()
                self.presentLoginViewController()
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }

    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */

    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
}
