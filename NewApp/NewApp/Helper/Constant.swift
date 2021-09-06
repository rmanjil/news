//
//  Constant.swift
//  Boomer11
//
//  Created by manjil on 20/08/2021.
//

import UIKit
import BaseDesignFramework

enum UserDefaultKey: String {
    case user = "user"
    case token = "token"
    case userDetail = "userDetail"
    case shownOnboarding 
}

enum AlertConstant: Alertable {
    case ok
    case logout
    case cancel
    
    var title: String {
        switch self {
        case .ok:
            return "Ok"
        case .logout:
            return "Logout"
        case .cancel:
            return "Cancel"
        }
    }
    
    var style: UIAlertAction.Style {
        switch self {
        case .logout:
            return .destructive
        default:
            return .default
        }
    }
    
    var tag: Int {
        return 0
    }
}

enum UserConstant {
    case email
    case password
    
    var value: String {
        switch self {
        case .email:
            return "example@gmail.com"
        case .password:
            return "123456"
        }
    }
}

