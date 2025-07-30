//
//  UserDefaultsManager.swift
//  Utils
//
//  Created by david.santiago on 29/07/25.
//
import Foundation

public final class UserDefaultsManager: @unchecked Sendable {
    
    private enum Keys {
        static let hideAmounts = "hideAmounts"
    }

    public static let shared = UserDefaultsManager()
    private init() {}

    public var hideAmounts: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.hideAmounts)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.hideAmounts)
        }
    }

    func reset() {
        UserDefaults.standard.removeObject(forKey: Keys.hideAmounts)
    }
}
