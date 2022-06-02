//
//  ExpertView.swift
//  Amicus
//
//  Created by Carl Rix on 12.05.22.
//  Modified by Nils Theres on 29.05.22
//

import SwiftUI

struct ExpertView: View {
    @Binding var tabSelection: Tabs
    @EnvironmentObject private var userState: UserStateViewModel
    @StateObject var requestModel = RequestViewModel()
    
    var body: some View {
        listView.onAppear {
            requestModel.retrieveOpenExpertPosts(categories: userState.expertCategories)
        }.foregroundColor(Color.amicusGreen)
    }
    
    @ViewBuilder
    var listView: some View {
        if !userState.isAuthenticated {
            constructView(requests: Placeholders.generateFullRequests(amount: 5)).navigationTitle("Expert")
        } else {
            constructView(requests: requestModel.expertPosts)
        }
    }
    
    @ViewBuilder
    func constructView(requests: [FullRequest]) -> some View {
        List(requests, id: \.id) { post in
            NavigationLink(
                destination: ExpertRequestView(tabSelection: .constant(Tabs.home) ,request: post),
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
            ExpertView(tabSelection: .constant(Tabs.home)).environmentObject(UserStateViewModel())
        }
    }
}
