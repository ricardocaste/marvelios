//
//  MarveliOSApp.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos on 11/9/22.
//

import SwiftUI

@main
struct MarvelApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some Scene {
        WindowGroup {
            // When testing do not run the whole app in order to speed up things
            if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
                        EmptyView()
            } else {
                HeroesListView()
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            }
        }
    }
}
