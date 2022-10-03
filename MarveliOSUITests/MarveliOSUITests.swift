//
//  MarveliOSUITests.swift
//  MarveliOSUITests
//
//  Created by Ricardo Castellanos on 20/9/22.
//

import XCTest

@testable import MarveliOS

class MarveliOSUITests: XCTestCase {

    let timeoutDuration: TimeInterval = 10.0
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIfSearchBarIsVisible() throws {
        let app = XCUIApplication()
        app.launch()
        
        //TODO: set to Spanish
        
        XCTContext.runActivity(named: "Verifying if 'Search Bar' screen is visible") { _ in
            let searchFields = app.searchFields["Buscar"]
            wait(element: searchFields, duration: timeoutDuration) { _ in
                XCTAssert(searchFields.exists)
                XCTAssert(searchFields.isHittable)
                XCTAssert(searchFields.isEnabled)
            }
        }
    }
    
    func testIfConfigurationIsVisible() throws {
        let app = XCUIApplication()
        app.launch()
        
        //TODO: set to Spanish
        
        XCTContext.runActivity(named: "Verifying if 'Configuration' button is visible") { _ in
            let searchFields = app.label["Configuración"]
            wait(element: searchFields, duration: timeoutDuration) { _ in
                XCTAssert(searchFields.exists)
                XCTAssert(searchFields.isHittable)
                XCTAssert(searchFields.isEnabled)
            }
        }
    }
    
    func testIfCharactersTableIsVisible() throws {
        let app = XCUIApplication()
        app.launch()
        
        XCTContext.runActivity(named: "Verifying if character table view is visible") { _ in
            let table = app.tables["CharacterListTableViewAccessibilityIdentifier"]

           wait(element: table, duration: timeoutDuration) { _ in
               XCTAssert(table.exists)
               XCTAssert(table.isHittable)
               XCTAssert(table.isEnabled)
               XCTAssertTrue(table.scrollBars.cells.count > 0)
           }
       }
    }
}

extension XCTestCase {
    func wait(element: XCUIElement, duration: TimeInterval, handler: @escaping (Error?) -> Void) {
        let exists = NSPredicate(format: "exists == true")

        expectation(for: exists, evaluatedWith: element) { () -> Bool in
            print("found it!")
            return true
        }

        waitForExpectations(timeout: duration) { error in
            if let notFoundError = error {
                handler(notFoundError)
            }
        }
    }
}
