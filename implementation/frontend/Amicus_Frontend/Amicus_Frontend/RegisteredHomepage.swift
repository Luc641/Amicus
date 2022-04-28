//
//  RegisteredHomepage.swift
//  Amicus_Frontend
//
//  Created by Luc Lehmkuhl on 26.04.22.
//

import SwiftUI



struct RegisteredHomepage: View {
    @State private var selection = 0
    
    var body: some View {
        NavbarView()
    }
    
}

struct RegisteredHomepage_Previews: PreviewProvider {
    static var previews: some View {
        RegisteredHomepage()
    }
}
