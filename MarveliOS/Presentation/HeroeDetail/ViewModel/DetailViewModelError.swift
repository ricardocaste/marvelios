//
//  DetailViewModelError.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos on 7/9/22.
//

import Foundation

enum DetailViewModelError: GenericErrorEnum {
    // In order to make it Identifiable
    var id: Self { self }

    case notConnectedToInternet
    case unknown
    case none

    var title: String {
        switch self {
        case .notConnectedToInternet:
            return "No Internet Connection"
        default:
            return "Error"
        }
    }

    var errorDescription: String {
        switch self {
        case .notConnectedToInternet:
            return "Please enable Wifi or Cellular data"
        case .unknown:
            return "An Unknown Error has occurred"
        case .none:
            return ""
        }
    }
}
