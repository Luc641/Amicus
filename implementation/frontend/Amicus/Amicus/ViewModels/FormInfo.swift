import Combine
import UIKit
import SwiftUIFormValidator
import SwiftUI

class FormInfo: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastNames: String = ""
    @Published var email: String = ""
    @Published var birthday: Date = Date()
    @Published var password: String = ""
    @Published var username: String = ""
    @Published var confirmPassword: String = ""
    @Published var form = FormValidation(validationType: .immediate, messages: ValidationMessages())
    
    lazy var firstNameValidation: ValidationContainer = {
        $firstName.nonEmptyValidator(form: form)
    }()
    
    lazy var lastNamesValidation: ValidationContainer = {
        $lastNames.nonEmptyValidator(form: form)
    }()
    
    lazy var emailValidation : ValidationContainer = {
        $email.emailValidator(form: form)
    }()
    
    
    lazy var singlePasswordValidation: ValidationContainer = {
        $password.countValidator(form: form, count: 8, type: .greaterThanOrEquals)
    }()
    
    lazy var passwordValidation: ValidationContainer = {
        $password.passwordMatchValidator(
            form: form,
            firstPassword: self.password,
            secondPassword: self.confirmPassword,
            secondPasswordPublisher: self.$confirmPassword)
    }()
    
    lazy var usernameValidation: ValidationContainer = {
        $username.inlineValidator(form: form) { value in
            !value.isEmpty && value.count >= 5;
        }
    }()
    
    
    lazy var birthdayValidation: ValidationContainer = {
        $birthday.dateValidator(form: form, before: Date(), errorMessage: "Date must be before today")
    }()
}

class ValidationMessages: DefaultValidationMessages {
    public override var required: String {
        "Required field"
    }
}
