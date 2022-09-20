//
//  Strings+LocalizationsTests.swift
//  MarveliOSTests
//
//  Created by Ricardo Castellanos on 20/9/22.
//

import Foundation
import XCTest

@testable import MarveliOS


class String_LocalizationTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLocalizedStringFile() {
        
        //TODO: set to Spanish
        
        let settingsButton = "settings".localized
        XCTAssertEqual(settingsButton, "Configuración")
        
        let loading = "loading".localized
        XCTAssertEqual(loading, "Cargando...")
        
        let heroesListScreenTitle = "heroes".localized
        XCTAssertEqual(heroesListScreenTitle, "Héroes")
    }
}
