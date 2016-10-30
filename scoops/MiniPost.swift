//
//  MiniPost.swift
//  scoops
//
//  Created by Edu González on 30/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation

class MiniPost {

    // MARK: - stored properties
    var title: String
    var photoURL: URL?
    var author: String
    var publicated: Bool
    var id: String

    // MARK: - computed properties
    var photo: UIImage {
        get {
            guard let data = NSData(contentsOf: photoURL!) else {
                return UIImage(named: "noImage.png")!
            }
            return UIImage(data: data as Data)!
        }
    }

    init(title:String,
         photoURL:URL,
         author:String,
         publicated:Bool,
         id:String) {

        self.title = title
        self.photoURL = photoURL
        self.author = author
        self.publicated = publicated
        self.id = id
    }
}
