//
//  Errors.swift
//  scoops
//
//  Created by Edu González on 22/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation

// MARK: - JSON Errors
enum ScoopsError : Error {

    case jsonParsingError
    case wrongJSONFormat
    case wrongURLFormatForJSONResource
    case errorDecodingJSON
    case resourcePointedByUrlNotReachable
    case nilJSONObject
}
