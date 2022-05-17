//
//  UserProfileView.swift
//  Amicus_Frontend
//
//  Created by Luc Lehmkuhl on 28.04.22.
//

import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var userState: UserStateViewModel
    
    var body: some View {
        VStack() {
            Image("ExamplePicture")
                .resizable()
                .cornerRadius(50)
                .padding(.all, 4)
                .frame(width: 200, height: 200)
                .background(Color.black.opacity(0.2))
                .clipShape(Circle())
            
            
            Form {
                Section(header: Text("First name")) {
                    Text(userState.info?.firstName ?? "not present")
                }
                
                Section(header: Text("Last name")) {
                    Text(userState.info?.lastName ?? "not present")
                }
                
                Section(header: Text("Username")) {
                    Text(userState.info?.username ?? "not present")
                }
                
                Section(header: Text("Email")) {
                    Text(userState.info?.email ?? "not present")
                }
            }
            .background(Color.amicusLight)
            .foregroundColor(Color.amicusGreen)
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView().environmentObject(UserStateViewModel())
    }
}
