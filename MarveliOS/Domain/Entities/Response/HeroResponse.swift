//
//  HeroeResponse.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos Herreros on 6/9/22.
//

import Foundation
import BackedCodable

/// Using BackedDecodable in order to decode nested JSON with property wrappers
struct HeroResponse: BackedDecodable {

    /// Default init for Backed Framework
    init(_: DeferredDecoder) {}

    /// Uses custom path for nested JSON
    @Backed(Path("data", "results"))
    var heroes: [Hero]
}
