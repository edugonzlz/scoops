//
//  FolderTableViewController.swift
//  scoops
//
//  Created by Edu González on 24/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import UIKit

class FolderTableViewController: UITableViewController {

    var model = Folder()
    let nc = NotificationCenter.default

    @IBAction func loginButton(_ sender: UIBarButtonItem) {
        checkAuth()
    }
    @IBOutlet weak var createPostButton: UIBarButtonItem!

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        syncWithModel()
        checkAuth()
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

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postDetailSegue" {
            let path = self.tableView.indexPathForSelectedRow
            let post = self.model.post(forIndexPath: path!)

            let nextVC = segue.destination as? PostDetailViewController
            nextVC?.model = post
        }
    }

    // MARK: - Utils
    func syncWithModel() {
        self.tableView.reloadData()

        // Ocultamos o mostramos el boton de creacion de post segun estemos logeados
        if !(isUserAuth()) {
            self.navigationItem.rightBarButtonItem = nil
        } else {
            self.navigationItem.rightBarButtonItem = self.createPostButton
        }
    }
    func checkAuth() {
        // si no estamos autenticados presentamos la vista para hacerlo
        if !(isUserAuth()){
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginModal")
            loginVC?.modalPresentationStyle = .pageSheet
            loginVC?.modalTransitionStyle = .flipHorizontal
            present(loginVC!, animated: true, completion: nil)
        }
        // si estamos autenticados avisamos con una alerta
        if isUserAuth(){
            let alert = UIAlertController(title: nil, message: "You´re logged", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
