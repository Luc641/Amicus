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
    let info: UserInfo
    let avatar: MediaResponse
}

struct UserInfo: Codable {
    let firstName, lastName, email: String
    let id: Int
    let birthDate, address, username: String
}

struct MediaResponse: Codable {
    let name: String
    let data, dataType: String
    
    
    func decodeData() -> Data {
        return Data(base64Encoded: data)!
    }
}

struct Category: Codable, Hashable {
    let id: Int
    let categoryName: String
}

typealias Categories = [Category]

