//
//  HomepageView.swift
//  Amicus_Frontend
//
//  Created by Luc Lehmkuhl on 21.04.22.
//

import SwiftUI

struct HomepageView: View {
    @State private var registerScreen =  false
    @State private var loginScreen = false
    
    var body: some View {
        VStack {
            Image("HelpingHands")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Button("Register here") {
                    registerScreen.toggle()
                }.buttonStyle(RegisterButton(background: Color("Amicus3")))
                    .padding(.top)
                
                //                Button("Sign in with Google") {
                //                }.buttonStyle(RegisterButton())
                //                Button("Sign in with Apple") {
                //                }.buttonStyle(RegisterButton())
                Text("Already have an account?")
                    .foregroundColor(Color("Amicus3"))
                    .multilineTextAlignment(.center)
                    .padding()
                Button("Log in") {
                    loginScreen.toggle()
                }.buttonStyle(RegisterButton(background: Color("Amicus3")))
                    .padding(.bottom, 50.0)
            }.padding(.horizontal, 90.0)
                .background(Color("Amicus1"))
                .padding(.top, -20)
            
            
            
            Text("Welcome to Amicus")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding(.top, -750.0)
        }
        .padding(.all, -50.0)
        .navigate(to: RegistrationView(), when: $registerScreen)
        .navigate(to: LogInView(), when: $loginScreen)
    }
    
    struct HomepageView_Previews: PreviewProvider {
        static var previews: some View {
            HomepageView()
        }
    }
}
