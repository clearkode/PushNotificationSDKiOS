//
//  PushNotificationLibraryDemoApp.swift
//  PushNotificationLibraryDemo
//
//  Created by M A on 02/08/2023.
//

import SwiftUI
import PushNotificationLibrary

@main
struct PushNotificationLibraryDemoApp: App {
    init() {
        PushNotificationManager
            .builder()
            .withOptions([.alert,.sound])
            .build()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    let isRegisteredForPushNotification = PushNotificationManager.getSubscriptionStatus()
                    
                    if !isRegisteredForPushNotification {
                        PushNotificationManager.subscribe()
                    }
                }
        }
    }
}
