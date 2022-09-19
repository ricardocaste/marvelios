//
//  Heroe.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos Herreros on 6/9/22.
//

import Foundation
import BackedCodable

/// Using BackedDecodable in order to decode nested JSON with property wrappers
struct Hero: BackedDecodable, Identifiable, Hashable, Comparable {

    @Backed()
    var id: Int // = UUID().uuidString

    @Backed()
    var name: String

    @Backed()
    var description: String

    /// Uses custom path for nested JSON
    @Backed(Path("thumbnail", "path"))
    var imagePath: String

    @Backed(Path("thumbnail", "extension"))
    var imageExtension: String

    @Backed(Path("comics", "items"))
    var comics: [ComicHero]
    
    @Backed(Path("series", "items"))
    var series: [Serie]
    
    @Backed(Path("events", "items"))
    var events: [Event]

    /// Default init for Backed Framework
    init(_: DeferredDecoder) {  }

    private enum CodingKeys: String, CodingKey {
        case id
    }

    // swiftlint:disable:next line_length
    init(id: Int, name: String, description: String, imageURLString: String, comics: [ComicHero], series: [Serie], events: [Event]) {

        self.$id = id
        self.$name = name
        self.$description = description

        let urlExtension = imageURLString.fileExtension()
        self.$imageExtension = urlExtension
        self.$imagePath = imageURLString.replacingOccurrences(of: ".\(urlExtension)", with: "")
        self.$comics = comics
        self.$series = series
        self.$events = events
    }

    static func == (lhs: Hero, rhs: Hero) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.imageURL == rhs.imageURL &&
        lhs.description == rhs.description &&
        lhs.comics.count == rhs.comics.count &&
        lhs.series.count == rhs.series.count &&
        lhs.events.count == rhs.events.count
    }

    static func < (lhs: Hero, rhs: Hero) -> Bool {
        lhs.name < rhs.name
    }

}

extension Hero {
    var imageURL: URL {
        let urlString = String("\(imagePath).\(imageExtension)")
        return URL(string: urlString)!
    }

    static var random: Hero {
        Hero(id: 0,
            name: "This hero is a test",
            description: "This is a description for a random user",
            imageURLString: "http://i.annihil.us/u/prod/marvel/i/mg/3/80/4c00358ec7548.jpg",
            comics: [],
            series: [],
            events: [])
    }

    static var randomThumbnail: Hero {
        Hero(id: 1,
            name: "This hero is a test",
            description: "This is a description for a random user",
            imageURLString: "http://i.annihil.us",
            comics: [],
            series: [],
            events: [])
    }
}
