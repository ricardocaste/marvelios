//
//  DependencyInjector.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos Herreros on 7/9/22.
//

import Foundation
import SwiftUI

struct DependencyInjector {
    static func getHeroesRepository() -> HeroesRepository {
        return HeroesRepository(service: HeroService())
    }

    static func getComicsRepository() -> ComicsRepository {
        return ComicsRepository(service: ComicService())
    }
}
