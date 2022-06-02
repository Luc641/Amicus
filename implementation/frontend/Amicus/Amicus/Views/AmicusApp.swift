//
//  Amicus_FrontendApp.swift
//  Amicus_Frontend
//
//  Created by Carl Rix on 19.04.22.
//

import SwiftUI

@main
struct AmicusApp: App {
    @StateObject var notificationCenter = NotificationCenter()
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            LandingPageView()
                .environmentObject(notificationCenter)
                .environmentObject(appDelegate.userState)
//            TestView()
        }
    }
}
