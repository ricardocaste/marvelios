//
//  LanguageSettingsView.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos on 19/9/22.
//

import SwiftUI

struct LanguageSettingsView: View {
    
    @State private var selectedLang:Int = 0
    var languages = ["English", "Español"]
    
    func languageChange(_ index: Int) {
        if index == 0{
            LocalPersistance.setLanguage(id: LocalPersistance.lang_eng)
        }
        else if index == 1{
            LocalPersistance.setLanguage(id: LocalPersistance.lang_spanish)
        }
        
        NotificationCenter.default.post(name: Notification.Name("changedLanguage"), object: nil)
    }
    
    var body: some View {
        Form{
            VStack{
                Section {
                    Picker(selection: $selectedLang.onChange(languageChange),
                           label: Text("select_language".localized)) {
                            
                            ForEach(0 ..< languages.count) { index in
                                Text(self.languages[index]).tag(index)
                            }
                    }
                }
            }
        }.onAppear() {
            (LocalPersistance.getLanguage() == "es") ?
                (selectedLang = 1) :
                (selectedLang = 0)
        }
    }
}

struct LanguageSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageSettingsView()
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}
