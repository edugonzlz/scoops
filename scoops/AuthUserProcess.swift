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
func removeFacebookUserInfo (){
    defaults.removeObject(forKey: userIDKey)
    defaults.removeObject(forKey: userFacebookToken)
}
func isUserAuth() -> Bool {

    let userId = defaults.value(forKey: userIDKey)
    let userToken = defaults.value(forKey: userFacebookToken)

    if userId != nil {
        client.currentUser = MSUser.init(userId: userId as! String?)
        client.currentUser?.mobileServiceAuthenticationToken = userToken as! String?

        return true

    } else {
        return false
    }
}
func userId() -> String {
    let userId = defaults.value(forKey: userIDKey)
    print("💥⛈💔UserId:\(userId)")
    return userId as! String
}
