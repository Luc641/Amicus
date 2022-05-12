//
//  FormRegistrationView.swift
//  Amicus_Frontend
//
//  Created by Nils Theres
//

import SwiftUI
import SwiftUIFormValidator


struct RegistrationView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var formInfo = FormInfo()
    @State var isSaveEnabled = false
    @State private var registerScreen = false
    
    @State private var image = UIImage()
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Picture")) {
                    HStack {
                        Image(uiImage: self.image)
                            .resizable()
                            .cornerRadius(50)
                        //.padding(.all, 4)
                            .frame(width: 120, height: 120)
                            .background(Color.black.opacity(0.2))
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                        //.padding(8)
                        Button(action: {
                            showSheet = true
                        }) {
                            Text("Add profile picture")
                        }
                        .sheet(isPresented: $showSheet) {
                            ImagePicker(sourceType: .camera, selectedImage: self.$image)
                            
                            //  If you want to take a picture from the library instead:
                            // ImagePicker(sourceType: .library, selectedImage: self.$image)
                        }
                    }
                }
                
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
                //                .listRowBackground(Color("
                
                Section(header: Text("Password")) {
                    SecureField("Password", text: $formInfo.password)
                        .validation(formInfo.singlePasswordValidation)
                    SecureField("Confirm Password", text: $formInfo.confirmPassword)
                        .validation(formInfo.passwordValidation)
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
            
            //                   observe the form validation and enable submit button only if it's valid
            .onReceive(formInfo.form.$allValid) { isValid in
                self.isSaveEnabled = isValid
            }
            // React to validation messages changes
            .onReceive(formInfo.form.$validationMessages) { messages in
                print(messages)
            }
            .navigationBarTitle("Registration")
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
        }
        .foregroundColor(Color("Amicus3"))
        .navigate(to: NavbarView(), when: $registerScreen)
    }
}

struct FormRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
