//
//  TestView.swift
//  Amicus
//
//  Created by Nils Theres on 28.05.22.
//

import SwiftUI
import CoreLocationUI


struct TestView: View {
    @StateObject var localNotification = LocalNotification()
       @ObservedObject var notificationCenter: NotificationCenter
       var body: some View {
           VStack {
               Button("schedule Notification") {
                   localNotification.setLocalNotification(title: "der titel",
                                                          subtitle: "sub titel",
                                                          body: "hallonoder so",
                                                          when: 10)
               }
               
               if let dumbData = notificationCenter.dumbData  {
                   Text("Old Notification Payload:")
                   Text(dumbData.actionIdentifier)
                   Text(dumbData.notification.request.content.body)
                   Text(dumbData.notification.request.content.title)
                   Text(dumbData.notification.request.content.subtitle)
               }
           }
       }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(notificationCenter: NotificationCenter())
    }
}
