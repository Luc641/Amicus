//
//  CategoryEndpoint.swift
//  Amicus
//
//  Created by Nils Theres on 27.05.22.
//

import Foundation

enum CategoryEndpoint {
    case retrieveAll
}


extension CategoryEndpoint : Endpoint {
    var path: String {
        switch self {
        case .retrieveAll:
            return "expert-categories"
        }
    }
}
