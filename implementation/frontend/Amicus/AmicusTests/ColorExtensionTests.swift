//
//  ColorExtensionTests.swift
//  AmicusTests
//
//  Created by Nils Theres on 17.05.22.
//

import XCTest
@testable import Amicus
import SwiftUI

class ColorExtensionTests: XCTestCase {

    func testAmicusLight() throws {
        XCTAssertEqual(Color("Amicus1"), Color.amicusLight)
    }
    
    func testAmicusLightGreen() throws {
        XCTAssertEqual(Color("Amicus2"), Color.amicusLightGreen)
    }
    
    func testAmicusGreen() throws {
        XCTAssertEqual(Color("Amicus3"), Color.amicusGreen)
    }
    
    func testAmicusDarkGreen() throws {
        XCTAssertEqual(Color("Amicus4"), Color.amicusDarkGreen)
    }
}
