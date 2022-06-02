//
//  AppDelegate.swift
//  Amicus
//
//  Created by Nils Theres on 31.05.22.
//

import Foundation
import SwiftUI

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    var userState: UserStateViewModel = UserStateViewModel()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    //No callback in simulator -- must use device to get valid push token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.hexString
        print(deviceTokenString)
        
        if userState.isAuthenticated {
            let userId = userState.info.info.id
            print(userId)
            
            Task {
                try! await WebClient.standard.uploadUserDeviceToken(userId: userId, deviceToken: deviceTokenString, authToken: KeychainHelper.standard.readAmicusToken() ?? "")
            }
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
}


extension UIApplicationDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Successfully registered for notifications!")
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for notifications: \(error.localizedDescription)")
    }
}
