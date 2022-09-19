//
//  LocalPersistance.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos on 19/9/22.
//

import Foundation

class LocalPersistance {
    
    private static let defaults = UserDefaults.standard
    static let LOCALSTORAGE_KEY = "LANGUAGE"
    static let lang_eng = "en"
    static let lang_spanish = "es"
    
    static func getLanguage() -> String? {
        var lang = defaults.string(forKey: LOCALSTORAGE_KEY)
        
        if lang == nil{
            //Set Default Language English
            lang = lang_eng
        }
        return lang
    }
    
    static func setLanguage(id: String) {
        defaults.set(id, forKey: LOCALSTORAGE_KEY)
    }
    
}
