//
//  Endpoint.swift
//  Amicus_Frontend
//
//  Created by Nils Theres on 06.05.22.
//

import Foundation


/// Endpoint protocol for accessing the API.
protocol Endpoint {
    
    /// The relative path of the API that should be accessed
    var path: String { get }
}

