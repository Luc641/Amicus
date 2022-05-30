//
//  TestLoginView2.swift
//  Amicus_Frontend
//
//  Created by Nils Theres on 04.05.22.
//

import SwiftUI
import SwiftUIFormValidator

struct LoginView: View {
    @StateObject private var loginModal: UserStateViewModel = UserStateViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var formInfo = FormInfo()
    @State private var validationSuccessful = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Please log in")
                        .font(.title2)
                        .foregroundColor(Color.amicusGreen)
                    
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
                    .buttonStyle(RegisterButton(background: Color("Amicus3")))
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
            }
            .navigationTitle("Login")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack{
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $loginModal.isAuthenticated, content: { NavbarView().environmentObject(loginModal) } )
            .foregroundColor(Color.amicusGreen)
        }
    }
    
    private var isLoginDisabled: Bool {
        loginModal.isAuthenticating || !formInfo.form.triggerValidation()
    }
}

struct NewLoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(UserStateViewModel())
    }
}
