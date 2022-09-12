//
//  Serie.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos on 7/9/22.
//

import Foundation

struct Serie: Codable, Hashable, Identifiable {
    var id: String = UUID().uuidString

    let name: String
    let resourceURI:String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case resourceURI
    }
}

