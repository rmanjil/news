//
//  LandingVideModel.swift
//  MVVMC
//
//  Created by manjil on 3/26/20.
//

import Foundation
import Combine
import BaseDesignFramework

class LandingViewModel: BaseViewModel {
    
    let email = TextModel(dataType: .email, interactor: TextInteractor(type: PlainFieldType.email, pattern: Pattern.email))
    let password = TextModel(dataType: .password, interactor: TextInteractor(type: PlainFieldType.password, pattern: Pattern.none))
    
    var  error = [AppError]()
    
    let message = PassthroughSubject<String, Never>()
    
    
   
    override init() {
        super.init()
        observeEvent()
    }
    
    func observeEvent() {
        Publishers.CombineLatest(email.$error, password.$error).map { (email, password) -> [AppError] in
            return [email, password].compactMap({ $0 })
        }.sink { [weak self] result in
            self?.error = result
        }.store(in: &bag)
    }
    
    
    func loginApi() -> (success: Bool, error: String) {
        if email.value.trim.lowercased() != UserConstant.email.value.lowercased() || password.value != UserConstant.password.value {
            return (false, "Invalid email or password." )
        }
        let user = User(email: email.value.trim)
       _ =  UserData.save(user: user)
        trigger.send(AppRoute.finish)
       return (true, "")
        
    }
}
