//
//  ExpertView.swift
//  Amicus
//
//  Created by Carl Rix on 12.05.22.
//  Modified by Nils Theres on 29.05.22
//

import SwiftUI

struct ExpertView: View {
    @EnvironmentObject private var userState: UserStateViewModel
    @StateObject var requestModel = RequestViewModel()
    
    var body: some View {
        listView.onAppear {
            requestModel.retrieveOpenExpertPosts(categories: userState.expertCategories)
        }.foregroundColor(Color.amicusGreen)
    }
    
    @ViewBuilder
    var listView: some View {
        if requestModel.expertPosts.isEmpty {
            offlineView
        } else {
            apiView
        }
    }
    
    var offlineView: some View {
        List(1...10, id: \.self) { index in
            NavigationLink(
                destination: ExpertRequestView(request: Placeholders.expertPosts[0]),
                label: {
                    HStack {
                        Image(systemName: "tray.full.fill")
                            .padding()
                        VStack {
                            Text("Advice \(index)")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                            Text("Category \(index)")
                                .font(.system(size: 15, design: .rounded))
                                .foregroundColor(Color.gray)
                        }
                    }
                })
        }.navigationTitle("Expert")
    }
    
    
    var apiView: some View {
        List(requestModel.expertPosts, id: \.id) { post in
            NavigationLink(
                destination: ExpertRequestView(request: post),
                label: {
                    HStack {
                        Image(systemName: "tray.full.fill")
                            .padding()
                        VStack {
                            Text(post.title)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                            Text(post.expertCategory.categoryName.capitalized)
                                .font(.system(size: 15, design: .rounded))
                                .foregroundColor(Color.gray)
                        }
                    }
                })
        }
    }
}

struct ExpertView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExpertView().environmentObject(UserStateViewModel())
        }
    }
}
