//
//  RegisteredHomepage.swift
//  Amicus_Frontend
//
//  Created by Luc Lehmkuhl on 26.04.22.
//

import SwiftUI



struct HomePageView: View {
    @State private var selection = 0
    
    var body: some View {
        List(1...10, id: \.self) { index in
            NavigationLink(
                destination: Text("Request #\(index) Details"),
                label: {
                    Text("Request #\(index)")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        
                })
            
        }
        .foregroundColor(Color("Amicus4"))
    }
}

struct RegisteredHomepage_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
