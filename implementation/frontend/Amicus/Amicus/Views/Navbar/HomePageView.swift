//
//  RegisteredHomepage.swift
//  Amicus_Frontend
//
//  Created by Luc Lehmkuhl on 26.04.22.
//

import SwiftUI



struct HomePageView: View {
    
    @Binding var tabSelection: Tabs
    @EnvironmentObject var userState: UserStateViewModel
    @StateObject var requestModel = RequestViewModel()
    
    var topNavigationButtons: some View {
        VStack {
            HStack {
                
                Text("Welcome back,")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                Text(userState.info.info.firstName)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }
            
            Button(action: {
                tabSelection = Tabs.request
            },
                   label: {
                HStack {
                    Text("Submit New Request")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(Color.gray)
                        .padding()
                    Spacer()
                    Image(systemName: "chevron.right")
                        .padding()
                }
            })
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
            
            Button(action: {
                tabSelection = Tabs.expert
            },
                   label: {
                HStack {
                    Text("Give expert advice")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(Color.gray)
                        .padding()
                    Spacer()
                    Image(systemName: "chevron.right")
                        .padding()
                }
            })
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
        }
        .padding()
    }
    
    @ViewBuilder
    var sections: some View {
        if requestModel.myPosts.isEmpty {
            let placeholders = Placeholders.generateFullRequests(amount: 5)
            constructView(myRequests:  placeholders, myAdvice:  placeholders)
        } else {
            constructView(myRequests: requestModel.myPosts, myAdvice: requestModel.myExpertAdvice)
            
        }
    }
    
    @ViewBuilder
    func constructView(myRequests: [FullRequest], myAdvice: [FullRequest]) -> some View {
        Form {
            topNavigationButtons
            Section(header: Text("Active requests").font(.system(size: 20, weight: .bold, design: .rounded))) {
                List(myRequests, id: \.id) { post in
                    NavigationLink {
                        DetailedRequestView(request: post)
                    }
                label: {
                    RequestRow(request: post)
                }
                }
            }
            
            Section(header: Text("Recent expert advice").font(.system(size: 20, weight: .bold, design: .rounded))) {
                List(myAdvice, id: \.id) { post in
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
    
    var body: some View {
        sections.onAppear {
            Task {
                let id = userState.info.info.id
                requestModel.retrieveMyAdvice(userId: id, isClosed: true)
                requestModel.retrieveMyRequests(userId: id, isClosed: false)
            }
        }
    }
    
}

struct RegisteredHomepage_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(tabSelection: .constant(Tabs.request)).environmentObject(UserStateViewModel())
    }
}
