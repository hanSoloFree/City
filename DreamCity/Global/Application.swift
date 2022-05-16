//
//  Application.swift
//  DreamCity
//
//  Created by 1 on 09.05.2022.
//

import UIKit

final class Application {
    
    static var shared = Application()
    
    private init() {}
    
    var notInitialApp: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaultsKey.notInitialApp.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.notInitialApp.rawValue)
        }
    }
    
    var music: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaultsKey.music.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.music.rawValue)
        }
    }
    
    var sound: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaultsKey.sound.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.sound.rawValue)
        }
    }
    
    var borders: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaultsKey.borders.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.borders.rawValue)
        }
    }
    
    var sectors: [String : Any] {
        get {
            return UserDefaults.standard.dictionary(forKey: UserDefaultsKey.sectors.rawValue) ?? ["":""]
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.sectors.rawValue)
        }
    }
    
    enum UserDefaultsKey: String {
        case notInitialApp
        case music
        case sound
        case borders
        case sectors
    }
}

