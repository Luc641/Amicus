//
//  ButtonStyles.swift
//  Amicus_Frontend
//
//  Created by Carl Rix on 25.04.22.
//

import Foundation
import SwiftUI


struct RegisterButton : ButtonStyle {
    let background: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(background)
            .foregroundColor(Color("Amicus1"))
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

//Textfield styling
struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color("Amicus2"))
            .cornerRadius(20)
            .shadow(color: .gray, radius: 10)
    }
}
