//
//  DataMapper.swift
//  TheNews
//
//  Created by manjil on 11/8/20.
//

import Foundation
struct DataMapper<T> where T: Decodable {

    /// Map jsonData to Model Confirming Decodable protocol
    ///
    /// - Parameter jsonData: jsonData
    /// - Returns: model if mapped else nil
    static func objectMapping(_ jsonData: [String: Any]) -> T? {
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            if let decodingError = error as? DecodingError {
                print(decodingError)
            } else {
                print(error.localizedDescription)
            }
            return nil
        }
    }

    /// Map jsonData of array to model
    ///
    /// - Parameter jsonData: jsonData
    /// - Returns: array of model data if mapped else empty array
    static func arrayMapping(_ jsonData: [[String: Any?]]) -> [T] {
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
            let objects = try JSONDecoder().decode([T].self, from: data)
            return objects
        } catch {
            if let decodingError = error as? DecodingError {
                print(decodingError)
            } else {
                print(error.localizedDescription)
            }
            return []
        }
    }

    static func objectMapping(_ data: Data) -> T? {
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            if let decodingError = error as? DecodingError {
                print(decodingError)
            } else {
                print(error.localizedDescription)
            }
            return nil
        }
    }

    static func arrayMapping(_ data: Data) -> [T] {
        do {
            let objects = try JSONDecoder().decode([T].self, from: data)
            return objects
        } catch {
            if let decodingError = error as? DecodingError {
                print(decodingError)
            } else {
                print(error.localizedDescription)
            }
            return []
        }
    }

}
