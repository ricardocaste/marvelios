import Combine
import SwiftUI

protocol ComicServiceProtocol {
    func getComicsHero(name: String) async throws -> ComicResponse
}

struct ComicService: HTTPClient, ComicServiceProtocol {
    func getComicsHero(name: String = "") async throws -> ComicResponse {
        return try await sendRequest(endpoint: .comics(name: name), responseModel: ComicResponse.self) 
    }
}
