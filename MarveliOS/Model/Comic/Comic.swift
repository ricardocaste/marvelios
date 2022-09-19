//
//  Comic.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos on 19/9/22.
//

import Foundation
import BackedCodable

/// Using BackedDecodable in order to decode nested JSON with property wrappers
struct Comic: BackedDecodable, Identifiable, Hashable, Comparable {

    var id: String = UUID().uuidString

    @Backed()
    var title: String

//    @Backed()
//    var description: String

    /// Uses custom path for nested JSON
    @Backed(Path("thumbnail", "path"))
    var imagePath: String

    @Backed(Path("thumbnail", "extension"))
    var imageExtension: String

    /// Default init for Backed Framework
    init(_: DeferredDecoder) {  }

    private enum CodingKeys: String, CodingKey {
        case id
    }

    // swiftlint:disable:next line_length
    init(id: String, title: String, description: String, imageURLString: String) {
        self.id = id
        self.$title = title
//        self.$description = description

        let urlExtension = imageURLString.fileExtension()
        self.$imageExtension = urlExtension
        self.$imagePath = imageURLString.replacingOccurrences(of: ".\(urlExtension)", with: "")
    }

    static func == (lhs: Comic, rhs: Comic) -> Bool {
        lhs.id == rhs.id// &&
//        lhs.title == rhs.title &&
//        lhs.imageURL == rhs.imageURL &&
//        lhs.description == rhs.description
    }

    static func < (lhs: Comic, rhs: Comic) -> Bool {
        lhs.title < rhs.title
    }
}

extension Comic {
    var imageURL: URL {
        let urlString = String("\(imagePath).\(imageExtension)")
        return URL(string: urlString)!
    }

    static var random: Comic {
        Comic(id: UUID().uuidString,
            title: "This comic is a test",
            description: "This is a description for a random comic",
            imageURLString: "http://i.annihil.us/u/prod/marvel/i/mg/a/00/4bb6ab8966f74.jpg")
    }
}
