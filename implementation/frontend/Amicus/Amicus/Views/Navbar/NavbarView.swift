//
//  NavbarView.swift
//  Amicus_Frontend
//
//  Created by Luc Lehmkuhl on 26.04.22.
//

import SwiftUI


enum Tabs: String {
    case home = "Home"
    case expert = "Expert"
    case request = "Create a request"
    case history = "History requests"
    case profile = "Profile page"
    
    
}
struct NavbarView: View {
    @EnvironmentObject private var userState: UserStateViewModel
    @State private var selection: Tabs = .home
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                HomePageView(tabSelection: $selection).navigationTitle("Home")
            }.navigationViewStyle(.stack)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(Tabs.home)
            
            NavigationView {
                ExpertView()
                    .navigationTitle("Expert")
            }.navigationViewStyle(.stack)
                .tabItem {
                    Image(systemName: "brain.head.profile")
                    Text("Expert")
                }
                .tag(Tabs.expert)
            
            NavigationView {
                RequestView().navigationTitle("Create new request")
            }.navigationViewStyle(.stack)
                .tabItem {
                    Image(systemName: "plus.bubble")
                    Text("New Request")
                }
                .tag(Tabs.request)
            
            NavigationView {
                HistoryView().navigationTitle("Request history")
            }.navigationViewStyle(.stack)
                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("History")
                }
                .tag(Tabs.history)
            NavigationView {
                
                UserProfileView().navigationTitle("Profile")
            }.navigationViewStyle(.stack)
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
                .tag(Tabs.profile)
        }
        .foregroundColor(Color.amicusGreen)
        .accentColor(.amicusGreen)
        .onAppear {
            userState.retrieveExpertCategories()
        }
    }
}

struct NavbarView_Previews: PreviewProvider {
    static var previews: some View {
        NavbarView().environmentObject(UserStateViewModel())
    }
}
