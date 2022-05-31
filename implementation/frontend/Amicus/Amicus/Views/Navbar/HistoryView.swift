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
        if !userState.isAuthenticated {
            constructView(requests: Placeholders.generateFullRequests(amount: 5))
        } else {
            constructView(requests: requestModel.myPosts)
        }
    }
    
    @ViewBuilder
    func constructView(requests: [FullRequest]) -> some View {
        Form {
            Section(header: Text("My Closed Requests").font(.system(size: 20, weight: .bold, design: .rounded))) {
                List(requests, id: \.id) { post in
                    NavigationLink {
                        DetailedRequestView(request: post)
                    }
                label: {
                    RequestRow(request: post)
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
