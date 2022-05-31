//
//  HistoryRequestView.swift
//  Amicus
//
//  Created by Matei Grosu on 19/05/2022.
//  Modified by Nils Theres on 29/05/2022
//

import SwiftUI
import MapKit

struct DetailedRequestView: View {
    var request: FullRequest
    @State var image: UIImage?
    @State var locationName = "unknown location"
    
    var body: some View {
        HStack {
            Form {
                Section(header: Text("Category")) {
                    Text(request.expertCategory.categoryName.capitalized)
                }
                Section(header: Text("Description")) {
                    Text(request.content)
                }
                Section(header: Text("Image")) {
                    Image(uiImage: self.image ?? UIImage(named: "HelpingHands")!)
                        .resizable()
                        .background(Color.black.opacity(0.2))
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(25)
                        .onAppear {
                            Task {
                                self.image = await loadImage(mediaId: request.mediaId)
                            }
                        }
                }
                Section(header: Text("Location")) {
                    Text(locationName).onAppear {
                        Task {
                            let decoded = await decodeLocation(locationString: request.location)
                            self.locationName = "\(decoded.country!), \(decoded.locality!)"
                        }
                    }
                }
                
                Section("Expert response") {
                    Text(request.expertResponse?.content ?? "not answered yet")
                }
            }
            
        }.navigationTitle("Request: \(request.title)")
    }
}

struct HistoryRequestView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedRequestView(request: Placeholders.expertPosts[0])
    }
}
