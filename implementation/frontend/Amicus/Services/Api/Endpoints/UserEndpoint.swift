//
//  UserEndpoint.swift
//  Amicus_Frontend
//
//  Created by Nils Theres on 06.05.22.
//

import Foundation

enum UserEndpoint {
    case login
    case whoami
    case byId(id: Int)
    case register
    case categories(userId: Int)
    case deviceToken(userId: Int)
}

extension UserEndpoint: Endpoint {
    var path: String {
        switch self {
        case .login:
            return "users/login"
        case .byId(let id):
            return "users/\(id)"
        case .whoami:
            return "users/whoami"
        case .register:
            return "users"
        case .categories(let userId):
            return "app-users/\(userId)/expert-categories"
            
        case .deviceToken(let userId):
            return "app-users/\(userId)/device-token"
        }
    }
}
