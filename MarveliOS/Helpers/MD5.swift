//
//  MD5.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos Herreros on 7/9/22.
//

import Foundation
import CryptoKit

extension String {

    var md5: String {
        let hash = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())

        return hash.map {
            String(format: "%02hhx", $0)
        }
        .joined()
    }
}
