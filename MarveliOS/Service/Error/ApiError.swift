//
//  ApiError.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos Herreros on 7/9/22.
//

import Foundation

enum ApiError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorised
    case offline
    case unknown

    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorised:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}
