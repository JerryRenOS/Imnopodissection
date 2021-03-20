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
}

public enum UserDefaultKeys: String, CaseIterable {
    case languagePreferences = "langugae_preferences"
}
