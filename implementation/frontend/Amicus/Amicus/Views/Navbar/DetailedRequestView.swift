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
            }
            
        }.navigationTitle("Request: \(request.title)")
    }
    
    private func loadImage(mediaId: Int) async -> UIImage {
        let token = KeychainHelper.standard.readAmicusToken() ?? ""
        if let imageData = try? await WebClient.standard.retrieveMedia(id: request.mediaId, authToken: token) { return UIImage(data: imageData.decodeData())! }
        
        return UIImage(named: "HelpingHands")!
    }
    
    private func decodeLocation(locationString: String) async -> CLPlacemark {
        // 51.3704,6.1724
        let split = locationString.components(separatedBy: ",").map { coord in
            Double(coord) ?? 0
        }
        
        let coordinates = CLLocationCoordinate2D(latitude: split[0], longitude: split[1])
        return await retrieveLocation(location: coordinates)
    }
}

struct HistoryRequestView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedRequestView(request: Placeholders.expertPosts[0])
    }
}
