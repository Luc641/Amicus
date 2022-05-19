//
//  HistoryView.swift
//  Amicus
//
//  Created by Matei Grosu on 17/05/2022.
//

import SwiftUI

struct HistoryView: View {
    @State private var selection = 0
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("In progres")){
                    List(1...4, id: \.self) { index in
                        NavigationLink(
                            destination: Text("Request #\(index) Details"),
                            label: {
                                Text("Request #\(index)")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                            })
                    }
                }
                Section(header: Text("Accepted Requests")){
                    List(1...4, id: \.self) { index in
                        NavigationLink(
                            destination: Text("Request #\(index) Details"),
                            label: {
                                Text("Request #\(index)")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                            })
                    }
                }
                Section(header: Text("Declined Requests")){
                    List(1...4, id: \.self) { index in
                        NavigationLink(
                            destination: Text("Request #\(index) Details"),
                            label: {
                                Text("Request #\(index)")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                            })
                    }
                }
            }
            .foregroundColor(Color("Amicus4"))
            .navigationBarTitle(Text("History requests"))
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
