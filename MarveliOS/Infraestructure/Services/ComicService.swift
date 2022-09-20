//
//  ComicService.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos Herreros on 7/9/22.
//

import Combine
import SwiftUI

protocol ComicServiceProtocol {
    func getComicsHero(id: String) async throws -> ComicResponse
}

struct ComicService: HTTPClient, ComicServiceProtocol {
    func getComicsHero(id: String = "") async throws -> ComicResponse {
        return try await sendRequest(endpoint: .comics(id: id), responseModel: ComicResponse.self)
    }
}
