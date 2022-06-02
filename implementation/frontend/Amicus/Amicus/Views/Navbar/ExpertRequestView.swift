//
//  ExpertRequestView.swift
//  Amicus
//
//  Created by Carl Rix on 17.05.22.
//

import SwiftUI

struct ExpertRequestView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var image: UIImage?
    @State var advice: String = ""
    @EnvironmentObject var userState: UserStateViewModel
    var request: FullRequest
    @State var locationName: String = "unknown location"
    
    var body: some View {
        HStack{
            Form {
                Section("Attached Image") {
                    Image(uiImage: self.image ?? UIImage(named: "HelpingHands")!)
                        .resizable()
                        .background(Color.black.opacity(0.2))
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                        .onAppear {
                            Task {
                                self.image = await loadImage(mediaId: request.mediaId)
                            }
                        }
                }
                .font(.system(size: 15, weight: .bold, design: .rounded))
                
                Section("Request Information") {
                    Text(request.content)
                        .font(.system(size: 15, design: .rounded))
                }
                .font(.system(size: 15, weight: .bold, design: .rounded))
                
                
                Section(header: Text("Location")) {
                    Text(locationName).onAppear {
                        Task {
                            let decoded = await decodeLocation(locationString: request.location)
                            self.locationName = "\(decoded.country!), \(decoded.locality!)"
                        }
                    }
                }
                
                Section("Your Advice") {
                    TextEditor(text: $advice)
                }
                .font(.system(size: 15, weight: .bold, design: .rounded))
                
                Button(action: {
                    Task {
                        await respondToRequest(requestId: request.id, content: advice)
                        self.presentationMode.wrappedValue.dismiss()
                    }
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
    }
    
    private func respondToRequest(requestId: Int, content: String) async {
        let client = WebClient.standard
        print("advice is \(content)")
        let token = KeychainHelper.standard.readAmicusToken() ?? ""
        let _ = try! await client.createExpertResponse(for: requestId, content: content, authToken: token)
        _ = try! await client.updateExpertIdForRequest(for: requestId, expertId: userState.info.info.id, authToken: token)
    }
}

struct ExpertRequestView_Previews: PreviewProvider {
    static var previews: some View {
        ExpertRequestView(request: Placeholders.expertPosts[0] ).environmentObject(UserStateViewModel())
    }
}
