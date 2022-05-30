//
//  RequestViewModel.swift
//  Amicus
//
//  Created by Nils Theres on 27.05.22.
//

import Foundation
import UIKit
import CoreLocation


class RequestViewModel: ObservableObject {
    @Published var expertPosts = [FullRequest]()
    @Published var myPosts = [FullRequest]()
    @Published var myExpertAdvice = [FullRequest]()
    
    @MainActor func create(topic: String, description: String, category: Category, image: UIImage, coords: CLLocationCoordinate2D?, userId: Int) {
        Task {
            let token = KeychainHelper.standard.readAmicusToken()!
            let _ = try! await WebClient.standard.createHelpPost(
                title: topic, description: description,
                category: category, media: image, coords: coords, userId: userId, authToken: token
            )
        }
    }
    
    @MainActor func retrieveOpenExpertPosts(categories: Categories) {
        Task {
            do {
                // future api gate
                let _ = KeychainHelper.standard.readAmicusToken() ?? ""
                expertPosts = try await WebClient.standard.retrieveRequestsByCategory(categories: categories)
            } catch {
                print("could not fetch expert posts")
            }
        }
    }
    
    @MainActor func retrieveMyRequests(userId: Int, isClosed: Bool) {
        Task {
            do {
                let token = KeychainHelper.standard.readAmicusToken() ?? ""
                myPosts = try await WebClient.standard.retrieveMyRequests(userId: userId, isClosed: isClosed, authToken: token)
            } catch {
                print("could not fetch open posts")
            }
        }
    }
    
    @MainActor func retrieveMyAdvice(userId: Int, isClosed: Bool) {
        Task {
            do {
                // future api gate
                let token = KeychainHelper.standard.readAmicusToken() ?? ""
                myExpertAdvice = try await WebClient.standard.retrieveAdviceRequests(userId: userId, isClosed: isClosed, authToken: token)
            } catch {
                print("could not fetch open expert advice ")
            }
        }
    }
}
