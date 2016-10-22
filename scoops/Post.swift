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
    var photoURL: URL?
    var location: (Double, Double)?
    var author: String
    var publicated: Bool = false
    var score: Int = 0
    var creationDate: Date = Date()

    // MARK: - computed properties
    var photo: UIImage {
        get {
            guard let data = NSData(contentsOf: photoURL!) else {
                    return UIImage(named: "")!
            }
            return UIImage(data: data as Data)!
        }
    }

    init(title:String,
        body:String,
        photoURL:URL,
        location:(Double,Double),
        author:String,
        publicated:Bool,
        score: Int,
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
//
//
//
//
//    }


}


