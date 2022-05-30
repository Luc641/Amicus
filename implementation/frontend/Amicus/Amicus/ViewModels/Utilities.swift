//
//  Utilities.swift
//  Amicus
//
//  Created by Nils Theres on 29.05.22.
//

import Foundation
import CoreLocationUI
import MapKit


func retrieveLocation(location: CLLocationCoordinate2D) async -> CLPlacemark {
    let longitude = location.longitude
    let latitude = location.latitude
    let transformed = CLLocation(latitude: latitude, longitude: longitude)
    // safe-guard this in the future - Nils
    return try! await CLGeocoder().reverseGeocodeLocation(transformed).first!
}

func loadImage(mediaId: Int) async -> UIImage {
    let token = KeychainHelper.standard.readAmicusToken() ?? ""
    if let imageData = try? await WebClient.standard.retrieveMedia(id: mediaId, authToken: token) { return UIImage(data: imageData.decodeData())! }
    
    return UIImage(named: "HelpingHands")!
}
