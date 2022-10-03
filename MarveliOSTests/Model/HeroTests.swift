//
//  HeroTests.swift
//  MarveliOSTests
//
//  Created by Ricardo Castellanos on 20/9/22.
//

import XCTest

@testable import MarveliOS

class HeroTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHeroValuesSetProperly() {
        let hero = Hero.random
        XCTAssertEqual(hero.name, "This hero is a test")
    }
}
