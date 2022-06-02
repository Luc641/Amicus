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
    @EnvironmentObject private var userModel: UserStateViewModel
    @StateObject private var categoryModel = CategoryViewModel()
    
    @State private var image = UIImage()
    @State private var showSheet = false
    @State private var showCamera = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Picture")) {
                    HStack {
                        Image(uiImage: self.image)
                            .resizable()
                            .cornerRadius(50)
                            .frame(width: 120, height: 120)
                            .background(Color.black.opacity(0.2))
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                        
                        Menu("Add Picture") {
                            Button(action: {showCamera = true}) {
                                HStack{
                                    Image(systemName: "camera")
                                    Text("Take picture")
                                }
                            }
                            Button(action: {showSheet = true}) {
                                HStack{
                                    Image(systemName: "photo")
                                    Text("Add from library")
                                }
                            }
                        }
                        .sheet(isPresented: $showCamera) {
                            ImagePicker(sourceType: .camera, selectedImage: self.$image)
                        }
                        .sheet(isPresented: $showSheet) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                        }
                        .onTapGesture(perform: simpleSuccess)
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
                
                Section(header: Text("Password")) {
                    SecureField("Password", text: $formInfo.password)
                        .validation(formInfo.singlePasswordValidation)
                        .textContentType(.oneTimeCode)
                    SecureField("Confirm Password", text: $formInfo.confirmPassword)
                        .validation(formInfo.passwordValidation)
                        .textContentType(.oneTimeCode)
                    
                }
                Section( header: Text("")) {
                    Picker("Expert Category", selection: $categoryModel.selection) {
                        ForEach(categoryModel.categories, id: \.self) { category in
                            Text(category.categoryName.capitalized)
                        }
                    }
                }
                Button(action: {
                    registerScreen = formInfo.form.triggerValidation()
                    userModel.register(firstName: formInfo.firstName, lastName: formInfo.lastNames, password: formInfo.password, birthDate: formInfo.birthday, email: formInfo.email, username: formInfo.username, avatar: self.image, categories: [categoryModel.selection])
                }, label: {
                    HStack {
                        Text("Submit")
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                    }
                }
                )
                .onTapGesture(perform: simpleSuccess)
                .disabled(isButtonDisabled)
            }.onAppear {
                categoryModel.populateCategories()
            }
            .onReceive(formInfo.form.$allValid) { isValid in
                self.isSaveEnabled = isValid
            }.gesture(DragGesture().onChanged { _ in
                guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                
                window.windows.forEach { $0.endEditing(true)}
            })
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
            .foregroundColor(Color.amicusGreen)
            .fullScreenCover(isPresented: $userModel.isAuthenticated, content: { NavbarView().environmentObject(userModel) } )
        }
    }
    
    private var isButtonDisabled: Bool {
        userModel.isAuthenticating || !formInfo.form.triggerValidation()
    }
}

struct FormRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView().environmentObject(UserStateViewModel())
    }
}
