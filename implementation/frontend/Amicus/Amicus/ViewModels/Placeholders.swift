//
//  Placeholders.swift
//  Amicus
//
//  Created by Nils Theres on 29.05.22.
//

import Foundation
import UIKit


final class Placeholders {
    static let image = UIImage(named: "HelpingHands")
    static let media = MediaResponse(name: "some media", id: 0, data: image!.pngData()!.base64EncodedString(), dataType: "png")
    static let user = UserResponse(info: UserInfo(firstName: "Test", lastName: "Last", email: "placeholder@a.com", id: 0, birthDate: "birth date", address: "some address", username: "username"), avatar: media)
    static let category = Category(id: 1, categoryName: "test cat")
    static let expertPosts = [FullRequest(id: 1, mediaId: 1, title: "test", content: "content", date: "date",  location: "51.3704,6.1724", expertCategory: category)]
    
    
    static func generateFullRequests(amount: Int) -> [FullRequest] {
        return (1...amount).map { num in
            FullRequest(id: num, mediaId: 1, title: "Test \(num)", content: "content \(num)", date: "date \(num)",  location: "51.3704,6.1724", expertCategory: category)
        }
    }
}
