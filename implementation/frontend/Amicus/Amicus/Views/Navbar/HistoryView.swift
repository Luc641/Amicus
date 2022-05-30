//
//  HistoryView.swift
//  Amicus
//
//  Created by Matei Grosu on 17/05/2022.
//

import SwiftUI

struct HistoryView: View {
    @StateObject var requestModel = RequestViewModel()
    @EnvironmentObject var userState: UserStateViewModel
    
    var body: some View {
        listView.onAppear {
            requestModel.retrieveMyRequests(userId: userState.info.info.id, isClosed: true)
        }
    }
    
    @ViewBuilder
    var listView: some View {
        if requestModel.myPosts.isEmpty {
            offlineView
        } else {
            apiView
        }
    }
    
    
    var apiView: some View {
        Form {
            Section(header: Text("My Requests").font(.system(size: 20, weight: .bold, design: .rounded))){
                List(requestModel.myPosts, id: \.id) { post in
                    NavigationLink {
                        DetailedRequestView(request: post) }
                label: {
                    RequestRow(request: post)
                }
                }
            }
        }
    }
    
    
    var offlineView: some View {
        Form {
            Section(header: Text("My Closed Requests").font(.system(size: 20, weight: .bold, design: .rounded))){
                List(1...4, id: \.self) { post in
                    NavigationLink {
                        DetailedRequestView(request: Placeholders.expertPosts[0]) }
                label: {
                    RequestRow(request: Placeholders.expertPosts[0])
                }
                }
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView().environmentObject(UserStateViewModel())
    }
}
