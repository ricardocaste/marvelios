//
//  HeroRepositoryTest.swift
//  MarveliOSTests
//
//  Created by Ricardo Castellanos on 12/9/22.
//

import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift

@testable import MarveliOS

class HeroRepositoryTests: XCTestCase {
    var heroService = HeroService()

    @JSONFile(named: "response")
    var response: HeroResponse?

    
    func testResponseHasValues() async throws {

        // GIVEN
        let heroRepository = HeroesRepository(service: heroService)

        stub(condition: isHost("gateway.marvel.com")) { _ in
            let stubPath = OHPathForFile("response.json", JSONReusable.self)
            return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
        }

        // WHEN
        let newHeroes = try await heroRepository.getHeroes(limit: 10, page: 3, offset: 0)

        // THEN check that an API call was retrieving heroes
        assert(!newHeroes.isEmpty)
    }
    
    func testResponseWithTenHeroes() async throws {

        // GIVEN
        let heroRepository = HeroesRepository(service: heroService)

        stub(condition: isHost("gateway.marvel.com")) { _ in
            let stubPath = OHPathForFile("response.json", JSONReusable.self)
            return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
        }

        // WHEN
        let newHeroes = try await heroRepository.getHeroes(limit: 10, page: 0, offset: 0)

        // THEN check that an API call was retrieving 10 heroes
        assert(newHeroes.count == 10)
    }
}
