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
                Section(header: Text("Accepted Requests").font(.system(size: 20, weight: .bold, design: .rounded))){
                    List(1...4, id: \.self) { index in
                        NavigationLink(
                            destination: HistoryRequestView(),
                            label: {
                                HStack {
                                    Image(systemName: "tray.fill")
                                        .padding()
                                    VStack(alignment: .leading) {
                                        Text("Request \(index)")
                                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                        VStack(alignment: .leading) {
                                            Text("Category \(index)")
                                            Text("Monday")
                                        }
                                        .font(.system(size: 15, design: .rounded))
                                        .foregroundColor(Color.gray)
                                    }
                                }
                            })
                    }
                }

                Section(header: Text("Declined Requests").font(.system(size: 20, weight: .bold, design: .rounded))){
                    List(1...4, id: \.self) { index in
                        NavigationLink(
                            destination: Text("Request #\(index) Details"),
                            label: {
                                HStack {
                                    Image(systemName: "tray.fill")
                                        .padding()
                                    VStack(alignment: .leading) {
                                        Text("Request \(index)")
                                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                        VStack(alignment: .leading) {
                                            Text("Category \(index)")
                                            Text("Monday")
                                        }
                                        .font(.system(size: 15, design: .rounded))
                                        .foregroundColor(Color.gray)
                                    }
                                }
                            })
                    }
                }
            }
            .foregroundColor(Color("Amicus3"))
            .navigationBarTitle(Text("History requests"))
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
