//
//  LandingVideController.swift
//  MVVMC
//
//  Created by manjil on 3/26/20.
// 
//

import UIKit
import Combine
import BaseDesignFramework

class LandingController: AppBaseController {
    /// The view
    private lazy var screenView: LandingScreen = {
        return baseView as! LandingScreen //swiftlint:disable:this force_cast
    }()
    
    /// The viewModel
    private lazy var viewModel: LandingViewModel = {
        return baseViewModel as! LandingViewModel //swiftlint:disable:this force_cast
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - override
    override func observeScreen() {
        
      
        screenView.passwordForgotButton.publisher(for: .touchUpInside).receive(on: RunLoop.main).sink { [weak self]_ in
            self?.viewModel.trigger.send(AuthRoute.forgotPassword)
        }.store(in: &viewModel.bag)
        
        screenView.loginWithEmailButton.publisher(for: .touchUpInside).receive(on: RunLoop.main).sink { [weak self]_ in
            self?.validateAndLogin()
        }.store(in: &viewModel.bag)
        
        
    }
    
    override func bindUI() {
        (screenView.emailField <-> viewModel.email).store(in: &viewModel.bag)
        (screenView.passwordField <-> viewModel.password).store(in: &viewModel.bag)
    }
    
    override func observeEvent() {
        viewModel.message.receive(on: RunLoop.main).subscribe(on: RunLoop.main).sink { [weak self] message in
            guard let self = self else { return }
            self.screenView.unFreezeAll()
            self.screenView.indicate = false
            self.alert(title: "Error", message: message, actions: [AlertConstant.ok])
        }.store(in: &viewModel.bag)
        
    }
}


extension LandingController {
    
    private func validateAndLogin() {
        screenView.endEditing(true)
        if viewModel.error.count > 0 {
            alert(title: "Error", message: viewModel.error[0].localizedDescription, actions: [AlertConstant.ok])
            return
        }
        self.screenView.freezeAll()
        self.screenView.indicate = true
        let value = viewModel.loginApi()
        self.screenView.unFreezeAll()
        self.screenView.indicate = false
        if !value.success {
            self.alert(title: "Error", message: value.error, actions: [AlertConstant.ok])
        }
    }
}
