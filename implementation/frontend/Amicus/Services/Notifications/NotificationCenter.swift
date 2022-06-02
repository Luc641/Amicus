//
//  NotificationCenter.swift
//  Amicus
//
//  Created by Nils Theres on 31.05.22.
//

import Foundation
import SwiftUI
import os

class NotificationCenter: NSObject, ObservableObject {
    @Published var dumbData: UNNotificationResponse?
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    @MainActor func requestNotificationAccess() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert]) {
            (allowed, error) in
            if allowed {
                print("received push notification access")
                DispatchQueue.main.async {
                  UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("did not receive push access")
            }
        }
    }
}

extension NotificationCenter: UNUserNotificationCenterDelegate  {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .badge])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        dumbData = response
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) { }
}

class LocalNotification: ObservableObject {
    init() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (allowed, error) in
            //This callback does not trigger on main loop be careful
            if allowed {
                os_log(.debug, "Allowed")
            } else {
                os_log(.debug, "Error")
            }
        }
    }
    
    func setLocalNotification(title: String, subtitle: String, body: String, when: Double) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: when, repeats: false)
        let request = UNNotificationRequest.init(identifier: "localNotificatoin", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
}
