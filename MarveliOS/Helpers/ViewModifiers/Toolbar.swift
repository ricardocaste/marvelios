//
//  Toolbar.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos Herreros on 6/9/22.
//

import Foundation
import SwiftUI

struct Toolbar: ViewModifier {

    func body(content: Content) -> some View {
        content.toolbar {
            ToolbarItem {
                NavigationLink(destination: SettingsView()) {
                    Text("Settings")
                }
            }
        }
    }
}

extension View {
     func makeToolbarItems() -> some View {
        modifier(Toolbar())
    }
}
