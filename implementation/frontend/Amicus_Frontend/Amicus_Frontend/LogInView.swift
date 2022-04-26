//
//  LogInView.swift
//  Amicus_Frontend
//
//  Created by Matei Grosu on 26/04/2022.
//

import SwiftUI

struct LogInView: View {
    
    //changes the backgroundcolor of the top navigation bar
    init() {
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = UIColor(Color("Amicus4"))
        
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var homeScreen = false
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            Color("Amicus1").ignoresSafeArea().overlay(
            VStack(alignment: .leading) {
                Group {
                    Text("Email/Username").foregroundColor(Color("Amicus1"))
                    TextField("Email", text: $email, prompt: Text("example@web.com").foregroundColor(Color("Amicus1")))
                        .textFieldStyle(OvalTextFieldStyle())
                    
                    Text("Password").foregroundColor(Color("Amicus1"))
                    TextField("Password", text: $password, prompt: Text("Required").foregroundColor(Color("Amicus1")))
                        .textFieldStyle(OvalTextFieldStyle())
                    NavigationLink(destination: HomepageView()) {
                        Button("Log-In"){
                            
                        }.padding().buttonStyle(RegisterButton(background: Color("Amicus4")))
                            
                    }
                }
                .frame(alignment: .center)
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                //Title
                ToolbarItem(placement: .principal) {
                    Text("Log-In")
                        .font(.title.bold())
                        .foregroundColor(Color("Amicus1"))
                    .accessibilityAddTraits(.isHeader)}
                
                //Home button and link to homepage
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                        homeScreen.toggle()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color("Amicus1"))
                            Text("Home")
                                .foregroundColor(Color("Amicus1"))
                        }
                    }
                }
            }
            .background(Color("Amicus3"))
            .cornerRadius(20)
            .padding()
        )}
        .navigate(to: HomepageView(), when: $homeScreen)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
