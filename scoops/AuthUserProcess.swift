//
//  AuthUserProcess.swift
//  scoops
//
//  Created by Edu González on 26/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation

func saveFacebookUserInfo(user: MSUser) {

    defaults.set(user.userId, forKey: userIDKey)
    defaults.set(user.mobileServiceAuthenticationToken, forKey: userFacebookToken)
    defaults.synchronize()
}
func isUserAuth() -> Bool {

    let userID = defaults.value(forKey: userIDKey)
    let userToken = defaults.value(forKey: userFacebookToken)

    if userID != nil {
        client.currentUser = MSUser.init(userId: userID as! String?)
        client.currentUser?.mobileServiceAuthenticationToken = userToken as! String?

        return true

    } else {
        return false
    }
}
