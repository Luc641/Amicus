//
//  MediaView.swift
//  Amicus
//
//  Created by Nils Theres on 16.05.22.
//

import SwiftUI

struct MediaView: View {
    @State private var image: UIImage?
    
    var body: some View {
        Image(uiImage: self.image  ?? UIImage(systemName: "captions.bubble")!)
            .onAppear {
                Task {
                    let media = try! await WebClient.standard.retrieveMedia(id: 2)
                    let decoded = media.decodeData()
                    // This is how uploading would work - Nils
//
//                    let _ = try! await WebClient.standard.uploadMedia(name: "uploadTest", data: decoded, fileType: "image")
                    self.image = UIImage(data: decoded)
                }
            }
    }
}

struct MediaView_Previews: PreviewProvider {
    static var previews: some View {
        MediaView()
    }
}
