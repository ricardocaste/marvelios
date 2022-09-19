//
//  Router.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos Herreros on 7/9/22.
//

import Foundation
import CryptoKit

enum Router: Equatable {
    case heroes(offset: String = "0", limit: String = "10")
    case comics(id: String)
    case image(destination: String)

    var url: String {API.URL + path}

    var path: String {
        switch self {
        case .heroes:
            return "/characters"
        case .comics(let id):
            return "/characters/\(id)/comics"
        case .image(let destination):
            return destination
        }
    }

    var parameters: [URLQueryItem]? {
        switch self {
        case .heroes(let offset, let limit):
            return [URLQueryItem(name: "ts", value: API.timeStamp),
                    URLQueryItem(name: "apikey", value: API.publicKey),
                    URLQueryItem(name: "hash", value: API.hash),
                    URLQueryItem(name: "limit", value: limit),
                    URLQueryItem(name: "offset", value: offset )]
        case .comics(_):
            return [URLQueryItem(name: "ts", value: API.timeStamp),
                    URLQueryItem(name: "apikey", value: API.publicKey),
                    URLQueryItem(name: "hash", value: API.hash)]
        default :
            return [URLQueryItem(name: "ts", value: API.timeStamp),
                    URLQueryItem(name: "apikey", value: API.publicKey),
                    URLQueryItem(name: "hash", value: API.hash)]
        }
    }

    var method: String {
        switch self {
        case .heroes:
            return "GET"
        case .comics:
            return "GET"
        default:
            return "GET"
        }
    }
}

struct API {
    //https://developer.marvel.com/documentation/authorization
    static var hash: String { "\(timeStamp)\(privateKey)\(publicKey)".md5 }
    static var publicKey: String { "f77e8f18458ca67aebd80b7bf22d93b2" }
    static var privateKey: String { "4c605f168e60bde541e6a0f6b318873071f7f3c9" }
    static var timeStamp: String { formatter.string(from: Date()) }
    static var URL: String {"https://gateway.marvel.com:443/v1/public"}

    private static let formatter: DateFormatter = {
        let form = DateFormatter()
        form.dateFormat = "yyyyMMddHHmmss"
          return form
          }()
}
