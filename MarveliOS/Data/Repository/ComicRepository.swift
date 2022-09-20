//
//  HeroesRepository.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos Herreros on 7/9/22.
//

import Foundation

class ComicsRepository: Repository {

    typealias Entity = ComicHero
    typealias Service = ComicServiceProtocol

    var service: Service

    required init(service: ComicServiceProtocol) {
        self.service = service
    }

    func getComics(id: String) async throws -> [Comic] {
        return try await self.service.getComicsHero(id: id).comics
    }
}
