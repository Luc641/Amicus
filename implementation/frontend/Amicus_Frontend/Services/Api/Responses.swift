//
//  Responses.swift
//  Amicus_Frontend
//
//  Created by Nils Theres on 03.05.22.
//

import Foundation


struct ApiError: Codable {
    let statusCode: Int
    let name, message: String
}

struct LoginResponse: Codable {
    let token: String?
    let error: ApiError?
}

struct PingResponse: Codable {
    let greeting, date, url: String
}

struct UserResponse: Codable {
    let firstName, lastName, email: String
    let id: Int
    let birthDate, address, username: String
}
