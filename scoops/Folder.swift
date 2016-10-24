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
    var allPosts = PostsArray()
    var publicatedPosts = PostsArray()
    var privatePosts = PostsArray()

    // MARK: - Inits
    init() {
//        readAllPostsFromAzure()
        readAllPostsFromAzureWithApi()
    }

    // MARK: - Methods

    // leer todos los posts de Azure y guardarlos en nuestro array
    // TODO: - para el caso del autor hay que leer solo los propios
    func readAllPostsFromAzure() {

        let postsTable = client.table(withName: postsTableKey)

        postsTable.read { (results, error) in

            if (error != nil) {
                return print("Error leyendo tabla:\(error)")
            }
            if let posts = results {

                for postDict in posts.items! {

                    // post es un diccionario
                    // inicializamos Post con cada diccionario
                    // y lo añadimos a nuestro array
                    do {
                        let post = try decode(postInDictionary: postDict as! JSONDictionary)

                        self.allPosts.append(post)
                        if post.publicated {
                            self.publicatedPosts.append(post)
                        } else {
                            self.privatePosts.append(post)
                        }
                    } catch {
                        print("error creando Post:\(error)")
                    }
                }
            }
        }
    }

    func readAllPostsFromAzureWithApi() {
        client.invokeAPI("getPosts",
                         body: nil,
                         httpMethod: "GET",
                         parameters: nil,
                         headers: nil) { (result, response, error) in

                            if error != nil {
                                return print("error invocando api getPosts:\(error)")
                            }
                            if let posts = result {

                                let JSONDict = posts as! [JSONDictionary]

                                self.allPosts.removeAll()
                                self.privatePosts.removeAll()
                                self.publicatedPosts.removeAll()

                                for postDict in JSONDict {

                                    // post es un diccionario
                                    // inicializamos Post con cada diccionario
                                    // y lo añadimos a nuestro array
                                    do {
                                        let post = try decode(postInDictionary: postDict )

                                        self.allPosts.append(post)
                                        if post.publicated {
                                            self.publicatedPosts.append(post)
                                        } else {
                                            self.privatePosts.append(post)
                                        }
                                    } catch {
                                        print("error creando Post:\(error)")
                                    }
                                }
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
    func post(forIndexPath indexPath: IndexPath) -> Post {

        if indexPath.section == 0 {
            return self.privatePosts[indexPath.row]
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
