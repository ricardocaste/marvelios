//
//  Option.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos on 12/9/22.
//

import SwiftUI
import Combine

struct Option: Codable {
    var id: Int
    var title: String
    var isAddSection: Bool
    var values: [InnerOptionValues]
}

struct InnerOptionValues: Codable {
    var title: String
    var isAddSection: Bool
    var isUseToggle: Bool
    var headerTitle: String
}

extension Option {
    static let generalValues: [InnerOptionValues] = [
        .init(title: "about", isAddSection: true, isUseToggle: false, headerTitle: ""),
        .init(title: "dark_apperance", isAddSection: true, isUseToggle: true, headerTitle: "APPERANCE"),
        .init(title: "language", isAddSection: false, isUseToggle: false, headerTitle: ""),
    ]
    
    static let developerValues: [InnerOptionValues] = [
        .init(title: "about_author", isAddSection: true, isUseToggle: false, headerTitle: ""),
    ]
    
    static let options: [Option] = [
        .init(id: 1, title: "general", isAddSection: false, values: generalValues),
        .init(id: 2, title: "developer", isAddSection: false, values: developerValues),
    ]
}
