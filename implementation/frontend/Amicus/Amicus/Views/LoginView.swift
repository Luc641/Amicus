//
//  TestLoginView2.swift
//  Amicus_Frontend
//
//  Created by Nils Theres on 04.05.22.
//

import SwiftUI
import SwiftUIFormValidator

struct LoginView: View {
    @StateObject private var loginModal: LoginViewModel = LoginViewModel()
    @ObservedObject private var formInfo = FormInfo()
    @State private var validationSuccessful = false
        
    var body: some View {
        ZStack {
            Color.amicusLight
                .ignoresSafeArea(.all)
            VStack {
                Text("Please log in")
                    .font(.title2)
                    .foregroundColor(Color.amicusDarkGreen)
                
                TextField("Email", text: $formInfo.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .validation(formInfo.emailValidation)
                
                SecureField("Password", text: $formInfo.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .validation(formInfo.singlePasswordValidation)
                
                Button(loginModal.isAuthenticating ? "Please wait" : "Log in"
                ) {
                    loginModal.login(email: formInfo.email, password: formInfo.password)
                }
                .disabled(isLoginDisabled)
                .foregroundColor(Color.amicusGreen)
                .padding()
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .opacity(loginModal.isAuthenticating ? 1.0 : 0.0)
                
                // Render the error
                Text(loginModal.apiErrorMessage ?? "")
                    .opacity(loginModal.apiErrorMessage != nil ? 1.0 : 0.0)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            .frame(maxWidth: 320)
            .padding(.horizontal)
            .onReceive(formInfo.form.$allValid) { isValid in self.validationSuccessful = !isValid }
        }.navigate(to: HomePageView(), when: $loginModal.isAuthenticated)
    }
    
    private var isLoginDisabled: Bool {
        loginModal.isAuthenticating || !formInfo.form.triggerValidation()
    }
}

struct NewLoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
