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
    @StateObject private var userModel = UserStateViewModel()
    
    @State var selection = ""
    var categories = ["Doctor", "Mechanic", "Plumber"]
    
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
                            //.aspectRatio(contentMode: .fill)
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
                    
                    TextField(
                        "Username",
                        text: $formInfo.username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .validation(formInfo.usernameValidation)
                    
                    TextField("Email", text: $formInfo.email)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
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
                Section( header: Text("")){
                    Picker(selection: $selection, label: Text("Expert Category")){
                        ForEach(categories, id: \.self){
                            Text($0)
                        }
                    }
                }
                Button(action: {
                    registerScreen = formInfo.form.triggerValidation()
                    userModel.register(firstName: formInfo.firstName, lastName: formInfo.lastNames, password: formInfo.password, birthDate: formInfo.birthday, email: formInfo.email, username: formInfo.username)
                }, label: {
                    HStack {
                        Text("Submit")
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                    }
                }
                )
                .disabled(isButtonDisabled)
            }
            //                   observe the form validation and enable submit button only if it's valid
            .onReceive(formInfo.form.$allValid) { isValid in
                self.isSaveEnabled = isValid
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
        .foregroundColor(Color.amicusGreen)
        .navigate(to: NavbarView(), when: $userModel.isAuthenticated)
    }
    
    private var isButtonDisabled: Bool {
        userModel.isAuthenticating || !formInfo.form.triggerValidation()
    }
}

struct FormRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
