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
                
                HomePageView(tabSelection: $selection)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .navigationBarHidden(true)
                    .tag(0)
                
                
                ExpertView()
                    .tabItem {
                        Image(systemName: "brain.head.profile")
                        Text("Expert")
                    }
                    .navigationBarHidden(true)
                    .tag(1)
                
                
                RequestView()
                    .tabItem {
                        Image(systemName: "plus.bubble")
                        Text("New Request")
                    }
                    .navigationBarHidden(true)
                    .tag(2)
                
                
                HistoryView()
                    .tabItem {
                        Image(systemName: "clock.arrow.circlepath")
                        Text("History")
                    }
                    .navigationBarHidden(true)
                    .tag(3)
                
                UserProfileView()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
                    .navigationBarHidden(true)
                    .tag(4)
            }
            .accentColor(.amicusGreen)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct NavbarView_Previews: PreviewProvider {
    static var previews: some View {
            NavbarView().environmentObject(UserStateViewModel())
    }
}
