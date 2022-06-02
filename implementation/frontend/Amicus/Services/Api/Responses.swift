//
//  Responses.swift
//  Amicus_Frontend
//
//  Created by Nils Theres on 03.05.22.
//

import Foundation


struct GenericResponse: Codable {
    let data: String?
}

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
    let id: Int?
    let data, dataType: String
    
    func getIdUnsafe() -> Int {
        return id!
    }
    
    func decodeData() -> Data {
        return Data(base64Encoded: data)!
    }
}

struct Category: Codable, Hashable {
    let id: Int
    let categoryName: String
}

typealias Categories = [Category]


struct Request: Codable {
    let title, content, date: String
    let location: String?
    let id: Int
    let isOpen: Bool
    let requesterId: Int
    let expertId: Int?
}

struct ExpertResponse: Codable, Hashable {
    let id: Int
    let content, date: String
    let requestId: Int
}


struct FullRequest: Codable, Hashable {
    let id, mediaId: Int
    let title, content, date: String
    let location: String
    let expertCategory: Category
    let expertResponse: ExpertResponse?
}


struct DeviceToken: Codable {
    let data: String
    let appUserId: Int
}
