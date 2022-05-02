//
//  Validation.swift
//  SwiftUI-Validation
//
// Created by Shaban on 24/05/2021.
//  Copyright © 2020 Sha. All rights reserved.
//

import Foundation

/// This enum represents the validation result
public enum Validation: Equatable {
    case success
    case failure(message: String)

    public var isFailure: Bool {
        !isSuccess
    }

    public var isSuccess: Bool {
        switch self {
        case .success: return true
        case .failure: return false
        }
    }

    static public func ==(lhs: Validation, rhs: Validation) -> Bool {
        switch (lhs, rhs) {
        case (.success, success):
            return true
        case (.failure(let a), .failure(let b)):
            return a == b
        default: return false
        }
    }
}
