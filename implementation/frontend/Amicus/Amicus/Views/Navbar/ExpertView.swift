//
//  ExpertView.swift
//  Amicus
//
//  Created by Carl Rix on 12.05.22.
//

import SwiftUI

struct ExpertView: View {
    @State private var selection = 0
    
    var body: some View {
        NavigationView {
            List(1...10, id: \.self) { index in
                NavigationLink(
                    destination: Text("Request #\(index) Details"),
                    label: {
                        Text("Request #\(index)")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        
                    })
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Expert")
            .foregroundColor(Color("Amicus3"))
        }
    }
}

struct ExpertView_Previews: PreviewProvider {
    static var previews: some View {
        ExpertView()
    }
}
