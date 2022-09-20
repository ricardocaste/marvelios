//
//  HeroesRepository.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos Herreros on 7/9/22.
//

import Foundation

class HeroesRepository: Repository {

    typealias Entity = Hero
    typealias Service = HeroServiceProtocol

    var service: Service

    required init(service: HeroServiceProtocol) {
        self.service = service
    }

    func getHeroes(limit: Int, page: Int, offset: Int) async throws -> [Hero] {
        return try await self.service.getHeroes(offset: "\(offset)", limit: "\(limit)").heroes
    }
}
