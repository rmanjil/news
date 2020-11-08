//
//  BaseController.swift
//  TheNews
//
//  Created by manjil on 11/8/20.
//

import UIKit
typealias AlertHandler = ((UIAlertAction) -> Swift.Void)?

class BaseController: UIViewController {
    let baseView: Baseview
    let baseViewModel: BaseViewModel
    
    init(view: Baseview, viewModel: BaseViewModel) {
        baseView = view
        baseViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = baseView
        
    }
    deinit {
        debugPrint("De-Initialized --> \(String(describing: self))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeEvent()
    }
    
    func observeEvent() {}
}

extension BaseController {
    /// Popup alert with message
    ///
    /// - Parameters:
    ///   - message: message
    func popAlert(with message: String) {
        alertActionHandler(with: message, firstAction: "OK", firstHandler: nil, secondAction: "", secondHandler: nil)
    }
    
    /// Popup alert with action handler
    ///
    /// - Parameters:
    ///   - message: message
    ///   - okTitle: action title
    ///   - handler: action handler
    func alertWithOkHandler(of title: String = "", message: String, okTitle: String = "OK", handler: AlertHandler) {
        alertActionHandler(of: title, with: message, firstAction: okTitle, firstHandler: handler, secondAction: "", secondHandler: nil)
    }
    
    /// Show Alert Controller
    ///
    /// - Parameters:
    ///   - message: message
    ///   - firstAction: first action title
    ///   - firstHandler: first  action handler
    ///   - secondAction: second action title
    ///   - secondHandler: second  action handler
    func alertActionHandler(of title: String = "", with message: String, firstAction: String, firstHandler: AlertHandler, secondAction: String, secondHandler: AlertHandler) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let firstAction = UIAlertAction(title: firstAction, style: .default, handler: firstHandler)
        
        if !secondAction.isEmpty {
            let secondAction = UIAlertAction(title: secondAction, style: .default, handler: secondHandler)
            alert.addAction(secondAction)
        }
        alert.addAction(firstAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
