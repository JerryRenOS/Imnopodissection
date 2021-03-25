//
//  Localizationalism.swift
//  Imnopodissection
//
//  Created by Jerry Ren on 3/19/21.
//

import Foundation

public struct Localizationalism {
    
    public static var languageValue: String = "Eng" {
        didSet {
            UserDefaults.standard.setValue(languageValue, forKey: UserDefaultKeys.languagePreferences.rawValue)
        }
    }
    
    public static func localizing(key: String, filename: String = "commonSensa", bundleIdentifier: String? = nil) -> String {
        let lang = Localizationalism.languageValue
        // fill this out gradually in future commits
        return String.init()
    }
}

public enum UserDefaultKeys: String, CaseIterable {
    case languagePreferences = "langugae_preferences"
}
