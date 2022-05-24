//
//  HistoryRequestView.swift
//  Amicus
//
//  Created by Matei Grosu on 19/05/2022.
//

import SwiftUI

struct HistoryRequestView: View {
    var body: some View {
        HStack{
            Form{
                Section(header: Text("Category")){
                    Text( "Category")
                }
                Section(header: Text("Description")){
                    Text( "Description")
                    //.multilineTextAlignment(.center)
                }
                Section(header: Text("Image")){
                    Image( "Picture")
                        .resizable()
                        .background(Color.black.opacity(0.2))
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(25)
                    //.frame(width: 250, height: 250)
                }
                Section(header: Text("Location")){
                    Text("from where")
                }
            }
            .navigationTitle(Text( "Topic"))
            .foregroundColor(Color.amicusGreen)
        }
    }
}

struct HistoryRequestView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryRequestView()
    }
}
