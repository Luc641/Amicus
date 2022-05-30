//
//  UserProfileView.swift
//  Amicus_Frontend
//
//  Created by Luc Lehmkuhl on 28.04.22.
//

import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var userState: UserStateViewModel
    @State var profilePicture: UIImage?
    
    
    var body: some View {
        VStack() {
            Image(uiImage: self.profilePicture  ?? UIImage(named: "ExamplePicture")!)
                .resizable()
                .cornerRadius(50)
            //.padding(.all, 4)
                .frame(width: 200, height: 200)
                .aspectRatio(contentMode: .fit)
                .background(Color.black.opacity(0.2))
                .clipShape(Circle())
                .onAppear {
                    let data = userState.info.avatar.decodeData()
                    self.profilePicture = UIImage(data: data)
                }
            
            Form {
                let user = userState.info.info
                Section(header: Text("First name")) {
                    Text(user.firstName )
                }
                
                Section(header: Text("Last name")) {
                    Text(user.lastName )
                }
                
                Section(header: Text("Username")) {
                    Text(user.username)
                }
                
                Section(header: Text("Email")) {
                    Text(user.email )
                }
            }
        }
    }
    
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView().environmentObject(UserStateViewModel())
    }
}
