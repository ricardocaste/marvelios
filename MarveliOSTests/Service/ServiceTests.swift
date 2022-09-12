//
//  ServiceTests.swift
//  MarveliOSTests
//
//  Created by Ricardo Castellanos on 12/9/22.
//

import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift

@testable import MarveliOS
class HeroeServiceTests: XCTestCase {

    var heroeService: HeroService!

    override func setUpWithError() throws {
        self.heroeService = HeroService()
    }

    func testShoulDecodeAPIResponse() async throws {

        // GIVEN
        // Hijacks URLSession in order to return mock success response
        stub(condition: isHost("gateway.marvel.com")) { _ in
            let stubPath = OHPathForFile("response.json", JSONReusable.self)
            return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
        }

        do {

            // WHEN
            let res = try await heroeService.getHeroes()

            // THEN
            assert(res.heroes.count == 10)
        } catch {
            XCTFail("API Should return success response")
        }
    }

    func testShouldReturnDecodingError() async throws {

        // GIVEN
        stub(condition: isHost("gateway.marvel.com")) { _ in
            if let data = try? JSONEncoder().encode("Error JSON") {
                return HTTPStubsResponse(data: data,
                                         statusCode: 200,
                                         headers: ["Content-Type": "application/json"])
            } else {
                fatalError("Could not encode data")
            }
        }

        do {
            // WHEN
            _ = try await heroeService.getHeroes()

        } catch  ApiError.decode {

            // THEN
            assert(true, "Expected Error")
        } catch {
            XCTFail("Could not get Data Response")
        }
    }

    func testShouldReturnUnauthorisedError() async throws {

        // GIVEN
        stub(condition: isHost("gateway.marvel.com")) { _ in

            let stubPath = OHPathForFile("response.json", JSONReusable.self)
            return HTTPStubsResponse(fileAtPath: stubPath!,
                                         statusCode: 401,
                                         headers: ["Content-Type": "application/json"])
        }
        do {
            // WHEN
            _ = try await heroeService.getHeroes()
        } catch ApiError.unauthorised {
            // THEN
            assert(true, "Expected Error")
        } catch {
            XCTFail("Could not get Data Response")
        }
    }

    func testShouldReturnUnexpectedStatusError() async throws {

        // GIVEN
        stub(condition: isHost("gateway.marvel.com")) { _ in
            if let data = try? JSONEncoder().encode("Error JSON") {
                return HTTPStubsResponse(data: data,
                                         statusCode: 500,
                                         headers: ["Content-Type": "application/json"])
            } else {
                fatalError("Could not encode data")
            }
        }

        do {
            // WHEN
            _ = try await heroeService.getHeroes()
        } catch ApiError.unknown {
            // THEN
            assert(true, "Expected Error")
        } catch {
            XCTFail("Could not get Data Response")
        }
    }

}

