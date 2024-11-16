//
//  AppDefault.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 15/11/24.
//

import Foundation

enum AppDefaultKey: String {
    case userProfile
}

class AppDefault {
    /// Convertes an object into `data` and saves in `UserDefault`
    /// - Parameter value: The object to be saved
    /// - Parameter key: The key to save the value in `UserDefaults`
    static func saveObject<T: Encodable>(value: T, key: AppDefaultKey) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(value) {
            save(value: data, key: key)
        }
    }
    
    /// Erases a object associated with determined key
    /// - Parameter key: The key to removed the object from
    static func removeObject(forKey key: AppDefaultKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    /// Loads a object as `T` type from the `UserDefaults`
    /// - Parameter type: The type of the object
    /// - Parameter key: The key to load the value in `UserDefaults`
    /// - Returns: An array of `T` type, or nil if the value for the key does not exist
    static func loadObject<T: Decodable>(type: T.Type, key: AppDefaultKey) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key.rawValue) else { return nil }
        
        if let object = try? JSONDecoder().decode(T.self, from: data) {
            return object
        }
        
        return nil
    }
    
    /// Saves a value in the `UserDefaults`
    /// - Parameter value: The value to be saved
    /// - Parameter key: The key to save the value in `UserDefaults`
    ///
    /// Pass the value as an `Data` type if possible, this way it always save with success. Call  `saveObject(value: _, key: _)` for saving a list or an object instead of this method directly
    static func save(value: Any?, key: AppDefaultKey) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    /// Returns the app name from the bundle, or `""` if `nil`
    static func appName() -> String {
        return (Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String) ?? ""
    }
}
