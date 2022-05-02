//
//  FormRegistrationView.swift
//  Amicus_Frontend
//
//  Created by Nils Theres
//

import SwiftUI
import SwiftUIFormValidator


struct FormRegistrationView: View {
    
    
    @ObservedObject var formInfo = FormInfo()
    @State var isSaveEnabled = false
    @State private var registerScreen = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: $formInfo.firstName)
                        .validation(formInfo.firstNameValidation)
                    
                    TextField(
                        "Last Name",
                        text: $formInfo.lastNames)
                    .validation(formInfo.lastNamesValidation)
                    
                    TextField("Email", text: $formInfo.email)
                        .validation(formInfo.emailValidation)
                    
                    DatePicker(
                        selection: $formInfo.birthday,
                        displayedComponents: [.date],
                        label: { Text("Birthday") }
                    ).validation(formInfo.birthdayValidation)
                }
                //                .listRowBackground(Color("Amicus1"))
                
                
                
                
                Section(header: Text("Password")) {
                    TextField("Password", text: $formInfo.password)
                        .validation(formInfo.passwordValidation)
                    TextField("Confirm Password", text: $formInfo.confirmPassword)
                }
                //                .listRowBackground(Color("Amicus1"))
                
                Button(action: {
                    registerScreen = formInfo.form.triggerValidation()
                }, label: {
                    HStack {
                        Text("Submit")
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                    }
                }
                )
            }
            .navigationBarTitle("Registration")
            //                   observe the form validation and enable submit button only if it's valid
            .onReceive(formInfo.form.$allValid) { isValid in
                self.isSaveEnabled = isValid
            }
            // React to validation messages changes
            .onReceive(formInfo.form.$validationMessages) { messages in
                print(messages)
            }
        }
        .foregroundColor(Color("Amicus3"))
        .navigate(to: NavbarView(), when: $registerScreen)
    }
}

struct FormRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        FormRegistrationView()
    }
}
