//
//  PushNotificationManagerProtocol.swift
//  PushNotificationLibrary
//
//  Created by M A on 02/08/2023.
//

import Foundation

public typealias SuccessResultCallback = (Bool) -> Void

protocol PushNotificationManagerProtocol {
    /// It returns true if the device has permission to display push notification else returns false.
    static func getPermissionStatus(completion: @escaping SuccessResultCallback)
    /// Registers the device for push notification
    static func subscribe()
    /// It returns true if the device has been registered for push notification else false.
    static func getSubscriptionStatus() -> Bool
    /// It returns  push token for the device if it has been registered for push notification else null.
    static func getSubscriptionToken() -> String?
}
