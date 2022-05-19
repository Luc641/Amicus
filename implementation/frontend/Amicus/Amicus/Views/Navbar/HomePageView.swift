//
//  RegisteredHomepage.swift
//  Amicus_Frontend
//
//  Created by Luc Lehmkuhl on 26.04.22.
//

import SwiftUI



struct HomePageView: View {
    
    @Binding var tabSelection: Int
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Welcome Back")) {
                    HStack {
                        Button(action: {
                            tabSelection = 2
                        },
                               label: {
                            HStack {
                                Text("Submit New Request")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .padding()
                                //Spacer()
                                //Image(systemName: "checkmark.circle.fill")
                            }
                        })
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                        .padding(10)
                        
                        Button(action: {
                            tabSelection = 1
                        },
                               label: {
                            HStack {
                                Text("Give expert advice")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .padding()
                                Spacer()
                                //Image(systemName: "checkmark.circle.fill")
                            }
                        })
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                        .padding(10)
                    }
                }
                
                Section(header: Text("Recent requests")) {
                    List(1...4, id: \.self) { index in
                        NavigationLink(
                            destination: Text("Request #\(index) Details"),
                            label: {
                                Text("Recent request #\(index)")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                            })
                    }
                }
                
                Section(header: Text("Recent expert advice")) {
                    List(1...4, id: \.self) { index in
                        NavigationLink(
                            destination: Text("Request #\(index) Details"),
                            label: {
                                Text("Expert advice #\(index)")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
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
        HomePageView(tabSelection: .constant(1))
    }
}
