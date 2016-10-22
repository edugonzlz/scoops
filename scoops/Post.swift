//
//  Post.swift
//  scoops
//
//  Created by Edu González on 22/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation
import UIKit

class Post {

    // MARK: - stored properties
    var title: String
    var body: String?
    var photoURL: String?
    var location: (Double, Double)?
    var author: String
    var publicated: Bool = false
    var creationDate: Date = Date()

    // MARK: - computed properties
    var photo: UIImage {
        get {
            guard let urlString = self.photoURL,
                let url = URL(string: urlString),
                let data = NSData(contentsOf: url) else {
                    return UIImage(named: "")!
            }
            return UIImage(data: data as Data)!
        }
    }

    init(title:String,
        body:String,
        photoURL:String,
        location:(Double,Double),
        author:String,
        publicated:Bool,
        creationDate:Date) {

        self.title = title
        self.photoURL = photoURL
        self.location = location
        self.author = author
        self.publicated = publicated
        self.creationDate = creationDate
    }

//    convenience init(dictionary: NSDictionary){
//
//
//
//    }


}


