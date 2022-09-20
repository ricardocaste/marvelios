//
//  ThemeSwitcher.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos Herreros on 6/9/22.
//

import Foundation
import SwiftUI

/// Toolbar View Modifier In Order to Abstract this layer (thinking about maintenance if the project becomes bigger)

struct ThemeSwitcher: ViewModifier {

    // Used To Change Theme Programmatically
    @AppStorage("isDarkMode") private var isDarkMode = false

    func body(content: Content) -> some View {
        content.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { toggleThemeChange()}, label: {
                    Label("Change Theme", systemImage: isDarkMode ? "sun.max.fill" : "moon.fill")
                })
            }
        }
    }

    func toggleThemeChange() {
        withAnimation {
                isDarkMode.toggle()
        }
    }
}

extension View {
    func themeSwitcher() -> some View {
        modifier(ThemeSwitcher())
    }
}
