//
//  NavbarView.swift
//  Amicus_Frontend
//
//  Created by Luc Lehmkuhl on 26.04.22.
//

import SwiftUI

struct NavbarView: View {
    @State private var selection = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                
                LandingPageView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)
                    .navigationTitle("Homepage")
                
                
                Text("Expert Tab")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .navigationTitle("Expert")
                    .tabItem {
                        Image(systemName: "brain.head.profile")
                        Text("Expert")
                    }
                    .tag(1)
                
                
                
                Text("Create Request")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "plus.bubble")
                        Text("New Request")
                    }
                    .tag(2)
                
                
                
                Text("Video Tab")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "clock.arrow.circlepath")
                        Text("History")
                    }
                    .tag(3)
                
                
                UserProfileView()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
                    .tag(4)
                    .navigationTitle("User")
            }
            .accentColor(Color("Amicus3"))
            .onAppear() {
                UITabBar.appearance().barTintColor = UIColor(Color("Amicus4"))
            }
            
            
        }
    }
}

struct NavbarView_Previews: PreviewProvider {
    static var previews: some View {
        NavbarView()
    }
}
