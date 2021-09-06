//
//  BaseController.swift
//  TheNews
//
//  Created by manjil on 11/8/20.
//

import UIKit
import BaseDesignFramework

enum BaseBarButton: Int {
    case back = 100
}

class AppBaseController: BaseController {
    
    lazy var backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(navBarButtonPressed(sender:)))
        backButton.tag = BaseBarButton.back.rawValue
        return backButton
    }()
    var showLeftBarButton = true 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navController = navigationController {
            let count = navController.viewControllers.count
            if count > 0 && showLeftBarButton {
                navigationItem.leftBarButtonItem = backButton
            }
        }
        observeEvent()
        bindUI()
        observeScreen()
       
    }
    
    @objc func navBarButtonPressed(sender: UIBarButtonItem) {
        switch sender.tag {
        case BaseBarButton.back.rawValue:
            navigationController?.popViewController(animated: true)
        default:
            break
        
        }
    }
    
    func observeEvent() {}
    func  observeScreen() {}
    func  bindUI() {}
}

