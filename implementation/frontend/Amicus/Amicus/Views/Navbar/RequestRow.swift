//
//  RequestRow.swift
//  Amicus
//
//  Created by Nils Theres on 29.05.22.
//

import SwiftUI

struct RequestRow: View {
    var request: FullRequest
    
    var body: some View {
        HStack {
            Image(systemName: "tray.fill")
                .padding()
            VStack(alignment: .leading) {
                Text("Request: \(request.title)")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                VStack(alignment: .leading) {
                    Text("Category \(request.expertCategory.categoryName)")
                }
                .font(.system(size: 15, design: .rounded))
                .foregroundColor(Color.gray)
            }
        }
    }
}

struct RequestRow_Previews: PreviewProvider {
    static var previews: some View {
        RequestRow(request: Placeholders.expertPosts[0])
    }
}
