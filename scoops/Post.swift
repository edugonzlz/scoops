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
    var body: String
    var photoURL: URL?
    var location: (latitude: Double, longitude: Double)?
    var author: String
    var publicated: Bool
    var score: Int?
    var creationDate: Date
    var id: String

    // MARK: - computed properties
    var photo: UIImage {
        get {
            guard let data = NSData(contentsOf: photoURL!) else {
                    return UIImage(named: "")!
            }
            return UIImage(data: data as Data)!
        }
    }
    var date: String {
        get {
            let formater = DateFormatter()
            formater.dateFormat = "dd/MM/yyy HH:mm"
            return formater.string(from: creationDate)
        }
    }

    init(title:String,
        body:String,
        photoURL:URL,
        location:(Double,Double),
        author:String,
        publicated:Bool,
        score: Int,
        creationDate:Date,
        id:String) {

        self.title = title
        self.body = body
        self.photoURL = photoURL
        self.location = location
        self.author = author
        self.publicated = publicated
        self.score = score
        self.creationDate = creationDate
        self.id = id
    }
}


