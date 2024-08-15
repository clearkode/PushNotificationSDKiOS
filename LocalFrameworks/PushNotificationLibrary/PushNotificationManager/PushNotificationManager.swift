//
//  PushNotificationManager.swift
//  PushNotificationLibrary
//
//  Created by M A on 02/08/2023.
//

import Foundation
import UIKit
import UserNotifications
import Firebase

final public class PushNotificationManager: NSObject {
    
    // MARK: Properties
    
    private static let notificationCenter = UNUserNotificationCenter.current()
    private static var options: UNAuthorizationOptions = [.alert,
                                                          .sound,
                                                          .badge]
    private static var isInitialised: Bool = false
    private static let tokenHandler = TokenHandler()
    
    // MARK: Initialisation
    
    public static func builder() -> Builder {
        return Builder()
    }
    
    private override init() {
        FirebaseApp.configure()
    }

    static private func throwErrorIfNotInitialised() {
        if !PushNotificationManager.isInitialised {
            fatalError("PushNotificationManager must be initialised before use. Call PushNotificationManager.builder().build() first.")
        }
    }
    
    static private func registerForPushNotification() {
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
            Messaging.messaging().delegate = tokenHandler
        }
    }
}

// MARK: Public API

extension PushNotificationManager: PushNotificationManagerProtocol {
    
    static public func getPermissionStatus(completion: @escaping SuccessResultCallback) {
        throwErrorIfNotInitialised()
        notificationCenter.getNotificationSettings { settings in
            let status = settings.authorizationStatus == .authorized
            DispatchQueue.main.async {
                completion(status)
            }
        }
    }
    
    static public func subscribe() {
        throwErrorIfNotInitialised()
        notificationCenter.requestAuthorization(options: options) { (granted, error) in
            guard granted else {
                return
            }
            registerForPushNotification()
        }
    }
    
    static public func getSubscriptionStatus() -> Bool {
        throwErrorIfNotInitialised()
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }
    
    static public func getSubscriptionToken() -> String? {
        throwErrorIfNotInitialised()
        return Messaging.messaging().fcmToken
    }
}

// MARK: - Builder

extension PushNotificationManager {
    public class Builder {
        private var pushNotificationManager: PushNotificationManager
        private var options: UNAuthorizationOptions = [.alert, .sound, .badge]
               
        public init() {
            pushNotificationManager = PushNotificationManager()
        }
        
        public func withOptions(_ options: UNAuthorizationOptions = [.alert, .sound, .badge]) -> Builder {
            self.options = options
            return self
        }
        
        @discardableResult
        public func build() -> PushNotificationManager {
            PushNotificationManager.options = options
            PushNotificationManager.isInitialised = true
            return pushNotificationManager
        }
    }
}

class TokenHandler: NSObject, MessagingDelegate {
    public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
    }
}
