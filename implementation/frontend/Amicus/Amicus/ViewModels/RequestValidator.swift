//
//  RequestValidator.swift
//  Amicus
//
//  Created by Luc Lehmkuhl on 02.06.22.
//

import Foundation
import Combine
import UIKit
import SwiftUIFormValidator
import SwiftUI
import MapKit
import CoreLocationUI

class RequestValidator: ObservableObject {
    @Published var description: String = ""
    @Published var topic: String = ""
    @Published var category: String = " "
    @Published var form = FormValidation(validationType: .immediate, messages: ValidationMessages())
    
    //    @Published var image: UIImage
    //    @Published var address: CLPlacemark?
    
    lazy var descriptionValidation: ValidationContainer = {
        $description.nonEmptyValidator(form: form)
    }()
    
    lazy var topicValidation: ValidationContainer = {
        $topic.nonEmptyValidator(form: form)
    }()
    
    lazy var categoryValidation: ValidationContainer = {
        $category.nonEmptyValidator(form: form)
    }()
    
    //    lazy var imageValidation : ValidationContainer = {
    //        $image.inlineValidator(form: form) { value in
    //            value
    //        }
    
    
    //    lazy var adressValidation: ValidationContainer = {
    //        $address.nonEmptyValidator(form: form)
    //    }()
    
    
}
