//
//  RegisteredHomepage.swift
//  Amicus_Frontend
//
//  Created by Luc Lehmkuhl on 26.04.22.
//

import SwiftUI



struct HomePageView: View {
    
    @Binding var tabSelection: Int
    @EnvironmentObject var userState: UserStateViewModel
    
    var body: some View {
        NavigationView {
            Form {
                    VStack {
                        HStack {
                            Text("Welcome back")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                            //Text(userState.info?.firstName ?? "")
                              //  .font(.system(size: 20, weight: .bold, design: .rounded))
                        }
                        
                        
                        Button(action: {
                            tabSelection = 2
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
                            tabSelection = 1
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
                
                
                Section(header: Text("Recent requests").font(.system(size: 20, weight: .bold, design: .rounded))) {
                    List(1...4, id: \.self) { index in
                        NavigationLink(
                            destination: Text("Request #\(index) Details"),
                            label: {
                                HStack {
                                    Image(systemName: "tray.fill")
                                        .padding()
                                    VStack(alignment: .leading) {
                                        Text("Request \(index)")
                                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                        VStack(alignment: .leading) {
                                            Text("Category \(index)")
                                            Text("Monday")
                                        }
                                        .font(.system(size: 15, design: .rounded))
                                        .foregroundColor(Color.gray)
                                    }
                                    //.frame(maxWidth: .infinity, alignment: .leading)
                                }
                            })
                    }
                }
                
                Section(header: Text("Recent expert advice").font(.system(size: 20, weight: .bold, design: .rounded))) {
                    List(1...4, id: \.self) { index in
                        NavigationLink(
                            destination: Text("Request #\(index) Details"),
                            label: {
                                HStack {
                                    Image(systemName: "tray.full.fill")
                                        .padding()
                                    VStack {
                                        Text("Advice \(index)")
                                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                        VStack(alignment: .leading) {
                                            Text("Category \(index)")
                                            Text("Monday")
                                        }
                                        .font(.system(size: 15, design: .rounded))
                                    .foregroundColor(Color.gray)
                                    }
                                }
                            })
                    }
                }
            }
            .buttonStyle(BorderlessButtonStyle())
            .navigationTitle("Home")
            .foregroundColor(Color("Amicus3"))
        }
    }
}

struct RegisteredHomepage_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(tabSelection: .constant(1)).environmentObject(UserStateViewModel())
    }
}
