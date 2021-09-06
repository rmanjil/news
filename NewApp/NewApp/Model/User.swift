//
//  User.swift
//  NewApp
//
//  Created by manjil on 06/09/2021.
//

import Foundation

struct User: Codable {
    var email: String = ""
}

enum UserData {
    static private let  cacher = Cacher<User>()
    
    static func save(user: User) -> Bool {
        cacher.setValue(user, key: .user)
    }
    
    static var get: User? {
        cacher.value(forKey: .user)
    }
    
    static var delete: Bool {
        cacher.delete(forKey: .user)
    }
    
}
