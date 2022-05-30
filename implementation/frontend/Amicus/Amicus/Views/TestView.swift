//
//  TestView.swift
//  Amicus
//
//  Created by Nils Theres on 28.05.22.
//

import SwiftUI
import CoreLocationUI


struct TestView: View {
    var body: some View {
        Text("hi").onAppear {
            Task {
                let cat = try! await WebClient.standard.retrieveCategories()
                let requests = try! await WebClient.standard.retrieveRequestsByCategory(categories: [cat[0]])
                print("hi")
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
