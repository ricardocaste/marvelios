//
//  Comic.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos Herreros on 6/9/22.
//

import Foundation

struct ComicHero: Codable, Hashable, Identifiable {
    var id: String = UUID().uuidString

    let name: String
    let resourceURI:String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case resourceURI
    }
}
