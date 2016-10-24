//
//  Settings.swift
//  scoops
//
//  Created by Edu González on 22/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation

typealias PostsArray = [Post]
typealias JSONObject = AnyObject
typealias JSONDictionary = [String: JSONObject]

let pruebaURL = "http://kc-mymobileapp.azurewebsites.net"
let azureServiceURL = "http://edu-scoops.azurewebsites.net"
let client: MSClient = MSClient(applicationURL: URL(string:azureServiceURL)!)

let postsTableKey = "Posts"

let titleKEY = "title"
let bodyKEY = "body"
let photoURLKEY = "photoURL"
let latitudeKEY = "latitude"
let longitudeKEY = "longitude"
let authorKEY = "author"
let publicatedKEY = "publicated"
let scoreKEY = "score"
let creationDateKEY = "creationDate"

let publicatedPostsSectionName = "Publicated Posts"
let privatePostsSectionName = "Private Posts"

let getAllPostsNotification = "Read all posts from Azure"

let nc = NotificationCenter.default
