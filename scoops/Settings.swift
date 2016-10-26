//
//  Settings.swift
//  scoops
//
//  Created by Edu González on 22/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation

// MARK: - Typealias
typealias PostsArray = [Post]
typealias JSONObject = AnyObject
typealias JSONDictionary = [String: JSONObject]

// MARK: - Service
let azureServiceURL = "https://edu-scoops.azurewebsites.net"
let client: MSClient = MSClient(applicationURL: URL(string:azureServiceURL)!)

// MARK: - Tables keys
let postsTableKey = "Posts"

// MARK: - JSON keys
let titleKEY = "title"
let bodyKEY = "body"
let photoURLKEY = "photoURL"
let latitudeKEY = "latitude"
let longitudeKEY = "longitude"
let authorKEY = "author"
let publicatedKEY = "publicated"
let scoreKEY = "score"
let creationDateKEY = "createdAt"

// MARK: - TableViews
let publicatedPostsSectionName = "Publicated Posts"
let privatePostsSectionName = "Private Posts"

// MARK: - Notifications
let getAllPostsNotification = "Read all posts from Azure"

// MARK: - Login Providers
let facebookProvider = "facebook"

// MARK: - UserDefaults
let defaults = UserDefaults.standard
let userIDKey = "User Id"
let userFacebookToken = "User Token for Facebook"
