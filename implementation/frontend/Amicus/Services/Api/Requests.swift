//
//  Requests.swift
//  Amicus_Frontend
//
//  Created by Nils Theres on 03.05.22.
//

import Foundation


protocol ApiRequestBody: Codable {
    // marker protocol
}

struct LoginRequestBody: ApiRequestBody {
    let email: String
    let password: String
}

struct CategoryRequest: ApiRequestBody {
    let categoryName: String
}

struct UserCreateRequestBody: ApiRequestBody {
    let firstName, lastName, email: String
    let address, passwordHash, username: String
    let birthDate: Date
    let profilePicture: MediaCreateRequestBody
    let expertCategories: [CategoryRequest]
}

struct MediaCreateRequestBody: ApiRequestBody {
    let data, name, dataType: String
    let appUserId: Int
}

struct RequestCreateBody: ApiRequestBody {
    let title, content: String
    let date: Date
    let location: String?
    let isOpen: Bool
    let requesterId, expertCategoryId, mediaId: Int
}

struct ExpertResponseBody: ApiRequestBody {
    let content: String
    let date: Date
    let requestId: Int
}


struct ExpertRequestPatchBody: ApiRequestBody {
    let expertId: Int
    let isOpen: Bool
}

struct DeviceTokenBody: ApiRequestBody {
    let data: String
    let appUserId: Int
}
