//
//  RootEndpoint.swift
//  Amicus_Frontend
//
//  Created by Nils Theres on 06.05.22.
//

import Foundation


enum RootEndpoint {
    case ping
}


extension RootEndpoint: Endpoint {
    var path: String {
        switch self {
        case .ping:
            return "ping"
        }
    }
}
