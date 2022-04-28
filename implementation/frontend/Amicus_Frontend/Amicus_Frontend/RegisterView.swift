//
//  RegistrationView.swift
//  Amicus_Frontend
//
//  Created by Carl Rix on 19.04.22.
//

import SwiftUI

let coloredNavAppearance = UINavigationBarAppearance()

struct RegistrationView: View {
    
    //changes the backgroundcolor of the top navigation bar
    init() {
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = UIColor(Color("Amicus4"))
        
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var homeScreen = false
    @State private var registeredScreen = false
    
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirm: String = ""
    
    var body: some View {
        NavigationView {
            Color("Amicus1").ignoresSafeArea().overlay(
                VStack(alignment: .leading) {
                    Group {
                        Text("First Name").foregroundColor(Color("Amicus1"))
                        TextField("First Name", text: $firstname, prompt: Text("Required"))
                            .textFieldStyle(OvalTextFieldStyle())
                            .foregroundColor(.red)
                        
                        Text("Last Name").foregroundColor(Color("Amicus1"))
                        TextField("Last Name", text: $lastname, prompt: Text("Required").foregroundColor(Color("Amicus1")))
                            .textFieldStyle(OvalTextFieldStyle())
                        
                        Text("Email").foregroundColor(Color("Amicus1"))
                        TextField("Email", text: $email, prompt: Text("Required").foregroundColor(Color("Amicus1")))
                            .textFieldStyle(OvalTextFieldStyle())
                        
                        Text("Password").foregroundColor(Color("Amicus1"))
                        TextField("Password", text: $password, prompt: Text("Required").foregroundColor(Color("Amicus1")))
                            .textFieldStyle(OvalTextFieldStyle())
                        
                        Text("Confirm Password").foregroundColor(Color("Amicus1"))
                        TextField("Confirm Password", text: $passwordConfirm, prompt: Text("Required").foregroundColor(Color("Amicus1")))
                            .textFieldStyle(OvalTextFieldStyle())
                    }
                    Group {
                        Text("Do you want to add additional information such as a profile picture and more?")
                            .foregroundColor(Color("Amicus1"))
                        
                        NavigationLink(destination: HomepageView()){
                            Text("Click here")
                        }.foregroundColor(Color("Amicus1"))
                        
                        NavigationLink(destination: HomepageView()) {
                            Button("Register"){
                                registeredScreen.toggle()
                                
                            }.padding().buttonStyle(RegisterButton(background: Color("Amicus4")))
                        }
                    }
                    .frame(alignment: .center)
                    //.padding(.horizontal, 100.0)
                    //.padding(.top, 10.0)
                }
                
                    .padding()
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        //Title
                        ToolbarItem(placement: .principal) {
                            Text("Register")
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
        .navigate(to: RegisteredHomepage(), when: $registeredScreen)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
