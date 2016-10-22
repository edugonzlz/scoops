//
//  JSONProcess.swift
//  scoops
//
//  Created by Edu González on 22/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation

func decode(postInDictionary dict:JSONDictionary) throws -> Post {

    guard let title = dict[titleKEY] as? String else {
        throw  ScoopsError.wrongJSONFormat
    }
    guard let body = dict[bodyKEY] as? String else {
        throw ScoopsError.wrongJSONFormat
    }
    guard let stringURL = dict[photoURLKEY] as? String,
        let photoURL = URL(string: stringURL) else {
            throw ScoopsError.wrongURLFormatForJSONResource
    }
    guard let locationDict = dict[locationKEY] as? NSDictionary,
        let latitude = locationDict[latitudeKEY] as? Double,
        let longitude = locationDict[longitudeKEY] as? Double else {
            throw ScoopsError.wrongJSONFormat
    }
    guard let author = dict[authorKEY] as? String else {
        throw ScoopsError.wrongJSONFormat
    }
    guard let score = dict[scoreKEY] as? Int else {
        throw ScoopsError.wrongJSONFormat
    }
    guard let publicated = dict[publicatedKEY] as? Bool else {
        throw ScoopsError.wrongJSONFormat
    }
    guard let dateNumber = dict[creationDateKEY] as? Double else {
        throw ScoopsError.wrongJSONFormat
    }

    let date = Date(timeIntervalSince1970: dateNumber)

    return Post(title: title,
                body: body,
                photoURL: photoURL,
                location: (latitude, longitude),
                author: author,
                publicated: publicated,
                score: score,
                creationDate: date)
}


// metodo para crear array de Posts si nos pasan los resultados de la peticion a Azure
func postArray(fromAzureResults items: [JSONDictionary]) -> PostsArray {

    var posts = PostsArray()

    for postDict in items {

        // post es un diccionario
        // inicializamos Post con cada diccionario
        // y lo añadimos a nuestro array
        do {
            let post = try decode(postInDictionary: postDict)

            posts.append(post)

        } catch {
            print("error creando Post:\(error)")
        }
    }

    return posts
}
