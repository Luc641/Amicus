//
//  RequestEndpoint.swift
//  Amicus
//
//  Created by Nils Theres on 27.05.22.
//

import Foundation



enum RequestEndpoint {
    case create
    case byId(id: Int)
    case findForCategoryIds
    case createResponse(requestId: Int)
    case myRequests
    case myAdvice
}


extension RequestEndpoint : Endpoint {
    var path: String {
        switch self {
        case .create:
            return "requests"
        case .byId(let id):
            return "requests/\(id)"
        case .findForCategoryIds:
            return "/requests/categories"
        case .createResponse(let requestId):
            return "requests/\(requestId)/expert-response"
        case .myRequests:
            return "requests/mine"
        case .myAdvice:
            return "requests/expert"
        }
    }
}
