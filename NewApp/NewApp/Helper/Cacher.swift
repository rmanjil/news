//
//  Cacher.swift
//  Boomer11
//
//  Created by manjil on 20/08/2021.
//

import Foundation

struct Cacher<T: Codable> {
    private let userDefault = UserDefaults()
    
    
    /// Method to archive the decodable object and then save into userdefaults
    ///
    /// - Parameters:
    ///   - object: the object to archive
    ///   - key: the cacheKey for identification of object storage
    /// - Returns: true if successfully archived and saved, false otherwise
    @discardableResult
    public func setValue(_ object: T, key: UserDefaultKey) -> Bool {
        do {
            let encodedValue = try JSONEncoder().encode(object)
            userDefault.setValue(encodedValue, forKey: key.rawValue)
            return userDefault.synchronize()
        } catch {
            return false
        }
    }

   /// Method that fetch and decode the top level object from cache
    ///
    /// - Parameter key: the cacheKey for identification of object storage
    /// - Returns: object if successfully decoded and fetched, nil otherwise
    public func value(forKey key: UserDefaultKey) -> T? {
        guard let data = userDefault.value(forKey: key.rawValue) as? Data else { return nil }
        do {
            let decodedValue = try JSONDecoder().decode(T.self, from: data)
            return decodedValue
        } catch {
            return nil
        }
    }

    /// Deletes an object with the given key
    ///
    /// - Parameter key: the cache key
    /// - Returns: true if successfully deleted and synchronized
    @discardableResult
    public func delete(forKey key: UserDefaultKey) -> Bool {
        userDefault.removeObject(forKey: key.rawValue)
        return userDefault.synchronize()
    }
}
