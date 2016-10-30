//
//  Folder.swift
//  scoops
//
//  Created by Edu González on 22/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation

class Folder {

    // MARK: - stored properties
    var allPosts = MiniPostsArray()
    var publicatedPosts = MiniPostsArray()
    var privatePosts = MiniPostsArray()

    // MARK: - Inits
    init() {
        readAllPostsFromAzureWithApi()
    }

    // MARK: - Methods

    // leer todos los posts de Azure y guardarlos en nuestro array
    // TODO: - para el caso del autor hay que leer solo los propios
    func readAllPostsFromAzureWithApi() {
        client.invokeAPI("getPosts",
                         body: nil,
                         httpMethod: "GET",
                         parameters: nil,
                         headers: nil) { (result, response, error) in

                            if error != nil {
                                return print("💥⛈💔 Error invocando api getPosts:\(error)")
                            }
                            if let posts = result {

                                let JSONDicts = posts as! [JSONDictionary]

                                self.allPosts.removeAll()
                                self.privatePosts.removeAll()
                                self.publicatedPosts.removeAll()

                                for postDict in JSONDicts {

                                    // post es un diccionario
                                    // inicializamos Post con cada diccionario
                                    // y lo añadimos a nuestro array
                                    do {
                                        let post = try decode(miniPostInDictionary: postDict )

                                        self.allPosts.append(post)
                                        if post.publicated {
                                            self.publicatedPosts.append(post)
                                        } else {
                                            self.privatePosts.append(post)
                                        }
                                    } catch {
                                        print("💥⛈💔error creando Post:\(error)")
                                    }
                                }
                                let nc = NotificationCenter.default
                                let notif = Notification.init(name: Notification.Name(rawValue: getAllPostsNotification))
                                nc.post(notif)
                            }
        }

    }

    // numero de secciones
    func numberOfSections() -> Int {

        return 2
    }
    // cantidad de posts
    func postsCount() -> Int {

        return self.allPosts.count
    }
    func postCount(forSection section:Int) -> Int {

        if section == 0 {
            return self.privatePosts.count
        }
        if section == 1 {
            return self.publicatedPosts.count
        }
        return self.postsCount()
    }

    // post para una section (publicado o NO publicado)
    func miniPost(forIndexPath indexPath: IndexPath) -> MiniPost {

        if indexPath.section == 0 {
            if self.privatePosts.count != 0 {
                return self.privatePosts[indexPath.row]
            }
        }
        return self.publicatedPosts[indexPath.row]
    }
    // Nombre de las secciones
    func sectionName(forSection section: Int) -> String {
        if section == 0 {
            return privatePostsSectionName
        }
        if section == 1 {
            return publicatedPostsSectionName
        }
        return "section"
    }
    
}
