//
//  LoginViewModel.swift
//  Amicus_Frontend
//
//  Created by Nils Theres on 03.05.22.
//

import Foundation
import UIKit


class UserStateViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var isAuthenticating: Bool = false
    @Published var apiErrorMessage: String?
    @Published var info: UserResponse?
    
    @MainActor func login(email: String, password: String) {
        let storage = KeychainHelper.standard
        
        Task {
            isAuthenticating = true
            do {
                let token = try await WebClient.standard.login(email: email, password: password).token!
                info = try! await WebClient.standard.whoAmI(authToken: token)
                storage.save(ApiToken(accessToken: token), service: "token", account: "amicus")
                isAuthenticated = true
            } catch RequestError.unauthorized {
                apiErrorMessage = "Invalid credentials"
            } catch let error as RequestError {
                apiErrorMessage = error.customMessage
            }
            isAuthenticating = false
        }
    }
    
    func logout() {
        KeychainHelper.standard.delete(service: "token", account: "amicus")
        isAuthenticated = false
    }
    
    @MainActor func register(firstName: String, lastName: String, password: String, birthDate: Date, email: String, username: String, avatar: UIImage) {
        Task {
            isAuthenticating = true
            do {
                info = try await WebClient.standard.register(firstName, lastName, password, birthDate, email, username, avatar)
                let loggedIn = try await WebClient.standard.login(email: email, password: password).token!
                KeychainHelper.standard.save(ApiToken(accessToken: loggedIn), service: "token", account: "amicus")
                isAuthenticated = true
            } catch let error as RequestError {
                apiErrorMessage = error.customMessage
            }
            isAuthenticating = false
        }
    }
    
}
