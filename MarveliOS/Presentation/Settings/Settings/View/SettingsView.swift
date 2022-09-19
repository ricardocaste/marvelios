//
//  Settings.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos on 12/9/22.
//

import SwiftUI

struct SettingsView : View {
    @ObservedObject var setting = Settings()
    
    var body: some View {
            Form {
                ForEach(Option.options,id: \.id) { settingOption in
                    OptionRow(option: settingOption)
                }
            }
            .navigationTitle("settings".localized)
            .themeSwitcher()
            .navigationBarTitle("settings".localized)
    }
}

struct OptionRow: View {
    let option: Option
    var body: some View {
        Group() {
            if option.isAddSection {
                Section {
                    OptionSettingsView(option: option)
                }
            } else {
                OptionSettingsView(option: option)
            }
        }
    }
}


struct OptionSettingsView : View {
    let option: Option
    
    var body: some View {
        return NavigationLink(destination: OptionInnerDetail(option: option)) {
            HStack {
                Image("default")
                    .resizable()
                    .cornerRadius(12)
                    .frame(width: 25, height: 25)
                    .clipped()
                    .aspectRatio(contentMode: .fit)
                Text(NSLocalizedString(option.title.localized, comment: "Option title"))
                    .foregroundColor(.blue)
                    .font(.system(size: 18))
            }
        }
    }
}

struct OptionInnerDetail: View {
    let option: Option
    var body: some View {
        Form {
            ForEach(option.values,id: \.title) { valuesOption in
                OptionInnerView(value: valuesOption)
            }
        }
        .navigationBarTitle(Text(option.title.localized), displayMode: .inline)
    }
}

struct OptionInnerView: View {
    let value: InnerOptionValues
    var body: some View {
        Group() {
            if value.isAddSection && !value.isUseToggle {
                Section(header: Text(value.headerTitle.localized)) {
                    InnerView(value: value)
                }
            } else if !value.isAddSection && value.isUseToggle {
                ToggleView(value: value)
            } else if value.isAddSection && value.isUseToggle {
                Section(header: Text(value.headerTitle.localized)) {
                    ToggleView(value: value)
                }
            } else {
                InnerView(value: value)
            }
        }
    }
}

struct ToggleView: View {
    let value: InnerOptionValues
    @ObservedObject var toggle = Settings()
    
    var body: some View {
        HStack {
            Image("default")
                .resizable()
                .cornerRadius(12)
                .frame(width: 25, height: 25)
                .clipped()
                .aspectRatio(contentMode: .fit)
            
            Toggle(isOn: $toggle.isToggleOn) {
                Text(NSLocalizedString(value.title.localized, comment: "Option title"))
                    .foregroundColor(.blue)
                    .font(.system(size: 18))
            }
        }
    }
}

struct InnerView: View {
    let value: InnerOptionValues
    
    var body: some View {
        return NavigationLink(destination: EndView(value: value)) {
            HStack {
                Image("default")
                    .resizable()
                    .cornerRadius(12)
                    .frame(width: 25, height: 25)
                    .clipped()
                    .aspectRatio(contentMode: .fit)
                Text(NSLocalizedString(value.title.localized, comment: "Option title"))
                    .foregroundColor(.blue)
                    .font(.system(size: 18))
            }
        }
    }
}

enum Options : String, CaseIterable {
    case Language = "language"
    case About = "about"
}

struct EndView: View {
    let value: InnerOptionValues
    
    var body: some View {
        return NavigationViewManager.make(value)
    }
}

struct NavigationViewManager {
    @ViewBuilder
    static func make(_ value: InnerOptionValues) -> some View {
        switch value.title {
        case Options.Language.rawValue:
            LanguageSettingsView()
            .navigationTitle(value.title.localized)
        default:
            NavigationView {
                Text("coming_soon".localized).font(.system(size: 25))
                    .navigationBarTitle(value.title.localized , displayMode: .large)
            }
        }
    }
}
