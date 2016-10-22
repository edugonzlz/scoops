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

let azureServiceURL = "http://edu-kc-scoops.azurewebsites.net"
let client: MSClient = MSClient(applicationURL: URL(string:azureServiceURL)!)

let postsKey = "posts"

let titleKEY = "title"
let bodyKEY = "body"
let photoURLKEY = "photoURL"
let locationKEY = "location"
let latitudeKEY = "latitude"
let longitudeKEY = "longitude"
let authorKEY = "author"
let publicatedKEY = "publicated"
let scoreKEY = "score"
let creationDateKEY = "creationDate"

let publicatedPostsSectionName = "Publicated Posts"
let privatePostsSectionName = "Private Posts"
