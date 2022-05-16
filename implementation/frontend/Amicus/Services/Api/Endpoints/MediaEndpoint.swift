//
//  MediaEndpoint.swift
//  Amicus
//
//  Created by Nils Theres on 12.05.22.
//

import Foundation

enum MediaEndpoint {
    case upload
    case retrieveById(id: Int)
}


extension MediaEndpoint : Endpoint {
    var path: String {
        switch self {
        case .retrieveById(let id):
            return "media/\(id)"
        case .upload:
            return "media"
        }
    }
}
