//
//  HeroeService.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos Herreros on 7/9/22.
//

import Foundation
import Combine

protocol HeroServiceProtocol {
    func getHeroes(offset: String, limit: String) async throws -> HeroResponse
}

struct HeroService: HTTPClient, HeroServiceProtocol {
    func getHeroes(offset: String = "0", limit: String = "10") async throws -> HeroResponse {
        return try await sendRequest(endpoint: .heroes(offset: offset), responseModel: HeroResponse.self)
    }
}
