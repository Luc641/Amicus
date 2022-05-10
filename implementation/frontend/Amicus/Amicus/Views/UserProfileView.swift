//
//  UserProfileView.swift
//  Amicus_Frontend
//
//  Created by Luc Lehmkuhl on 28.04.22.
//

import SwiftUI

struct UserProfileView: View {
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        VStack() {
            Image("ExamplePicture")
                .resizable()
                .cornerRadius(50)
                .padding(.all, 4)
                .frame(width: 200, height: 200)
                .background(Color.black.opacity(0.2))
                .clipShape(Circle())
            
            
            Text("First Name").foregroundColor(Color("Amicus3"))
            TextField("First Name", text: $firstname, prompt: Text("Max").foregroundColor(Color("Amicus1")))
                .textFieldStyle(OvalTextFieldStyle())
            
            Text("Last Name").foregroundColor(Color("Amicus3"))
            TextField("Last Name", text: $lastname, prompt: Text("Mustermann").foregroundColor(Color("Amicus1")))
                .textFieldStyle(OvalTextFieldStyle())
            
            Text("Email").foregroundColor(Color("Amicus3"))
            TextField("Email", text: $email, prompt: Text("max.mustermann@gmail.com").foregroundColor(Color("Amicus1")))
                .textFieldStyle(OvalTextFieldStyle())
            
            Text("Password").foregroundColor(Color("Amicus3"))
            TextField("Password", text: $password, prompt: Text("12345678").foregroundColor(Color("Amicus1")))
                .textFieldStyle(OvalTextFieldStyle())
            
        }
        .padding(.vertical, 120.0)
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("Amicus1")/*@END_MENU_TOKEN@*/)
        
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
