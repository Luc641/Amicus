//
// Created by Shaban on 24/05/2021.
// Copyright (c) 2021 sha. All rights reserved.
//

import Combine
import Foundation

/// This validator validates if the email is valid or not.
public class EmailValidator: StringValidator {
    public var publisher: ValidationPublisher!
    public var subject: ValidationSubject = .init()
    public var onChanged: [OnValidationChange] = []
    let regex = try! NSRegularExpression(
            pattern: Regex.email.rawValue,
            options: .caseInsensitive)

    public init() {
    }

    public var errorMessage: StringProducerClosure = {
        ""
    }
    public var value: String = ""

    public func validate() -> Validation {
        let patternValidator = PatternValidator(pattern: regex)
        patternValidator.value = value
        patternValidator.errorMessage = errorMessage
        return patternValidator.validate()
    }

}
