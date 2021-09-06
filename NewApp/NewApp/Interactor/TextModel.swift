//
//  TextModel.swift
//  Future Astology
//
//  Created by manjil on 08/03/2021.
//

import Foundation
import UIKit
import Combine

//public protocol Localie {
//    var value: String { get }
//}

public enum AppError: Error, LocalizedError {
    case requiredField(String)
    case custom (String)
    
    
   public var localizedDescription: String {
        switch self {
        case .requiredField(let error): return error
        case .custom(let error): return  error
        }
    }
}

public protocol  Plainable {
    var name: String { get }
}
public protocol Fieldable {
    var   pattern: String { get }
}

public protocol TextFieldInteractable {
    func isValid(value: String?) -> AppError?
    var pattern: PatternIdentifiable {get set}
}

enum PlainFieldType: Plainable {
    case none
    case email
    case password
    case fullName
    case confirmPassword
    case dob
    case time
    case street
    case city
    case country
    case referral
    case phone
    
    
    var name: String {
        switch self {
        case .none:
            return ""
        case .email:
            return "email"
        case .password:
            return "password"
        case .fullName:
            return "full name"
        case .confirmPassword:
            return "confirm password"
        case .dob:
            return "date of birth"
        case .time:
            return "time"
        case .street:
            return "street"
        case .city:
            return "city"
        case .country:
            return "country"
        case .referral:
            return "referral code"
        case .phone:
            return "phone"
        }
    }
}

class TextModel: ObservableObject {
    

    var bag = Set<AnyCancellable>()
   
    @Published var value: String = ""
    @Published var error: AppError? = nil
    
    let dataType: Plainable
    let interactor: TextFieldInteractable
    init(dataType: PlainFieldType, interactor: TextFieldInteractable = TextInteractor(type: PlainFieldType.none, pattern: Pattern.none, optional: false) ) {
        self.dataType = dataType
        self.interactor  = interactor
        
        $value.sink { [weak self] value in
            guard let self = self else { return }
            self.isValid(value: value)
        }.store(in: &bag)
        
    }
    
    func isValid(value: String) {
        error = interactor.isValid(value: value)
      }
}




