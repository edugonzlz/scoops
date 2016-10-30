//
//  Notifications.swift
//  scoops
//
//  Created by Edu González on 30/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation
import UserNotifications

let center = UNUserNotificationCenter.current()

func authorizeNotifications() {

    //Pedimos autorizacion para recibir notificaciones
    center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
        guard error == nil else {
            return print("💥⛈💔Error con los permisos de notificaciones: \(error)")
        }
        if granted {
        } else {
            // Si no hay permisos podemos hacer algo
        }
    }

    // Limpia el indicador numerico de notificaciones en el icono
    UIApplication.shared.applicationIconBadgeNumber = 0

    // Nos registramos para poder recibir notificaciones remotas
    UIApplication.shared.registerForRemoteNotifications()
}
