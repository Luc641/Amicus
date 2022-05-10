//
//  RequestError.swift
//  Amicus_Frontend
//
//  Created by Nils Theres on 05.05.22.
//

import Foundation

enum RequestError: Error {
    case decode
    case internalErr
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Could not decode response"
        case .unauthorized:
            return "Not authorized"
        case .internalErr:
            return "Internal server error"
        case .noResponse:
            return "Server did not respond in time"
        default:
            return "Unknown error"
        }
    }
}
