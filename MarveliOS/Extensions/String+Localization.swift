//
//  String+Localization.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos on 19/9/22.
//

import Foundation

extension String {
    var localized: String {
        let language = LocalPersistance.getLanguage()
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let bundle: Bundle
        if let path = path {
            bundle = Bundle(path: path) ?? .main
        } else {
            bundle = .main
        }
        return localized(bundle: bundle)// localized(bundle: bundle, tableName: nil)
    }
      
    private func localized(bundle: Bundle) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}

    /// How to use
    // "hello".localized
