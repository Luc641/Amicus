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
