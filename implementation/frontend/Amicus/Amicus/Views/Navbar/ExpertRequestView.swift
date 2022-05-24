//
//  ExpertRequestView.swift
//  Amicus
//
//  Created by Carl Rix on 17.05.22.
//

import SwiftUI

struct ExpertRequestView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var image = UIImage()
    @State var advice: String = ""
    
    var body: some View {
        HStack{
            Form {
                Section(header: Text("Images")) {
                    Image(uiImage: self.image)
                        .resizable()
                        .background(Color.black.opacity(0.2))
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                    //.frame(width: 120, height: 120)
                }
                .font(.system(size: 15, weight: .bold, design: .rounded))
                
                Section(header: Text("Request Information")) {
                    Text("Advice information")
                        .font(.system(size: 15, design: .rounded))
                }
                .font(.system(size: 15, weight: .bold, design: .rounded))
                
                
                Section(header: Text("Your Advice")) {
                    TextField("Your advice", text: $advice)
                }
                .font(.system(size: 15, weight: .bold, design: .rounded))
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                },
                       label: {
                    HStack {
                        Text("Accept Request")
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                    }
                })
                .onTapGesture(perform: simpleSuccess)
            }
        }
        .navigationTitle("Request")
        .foregroundColor(Color.amicusGreen)
    }
}

struct ExpertRequestView_Previews: PreviewProvider {
    static var previews: some View {
        ExpertRequestView()
    }
}
