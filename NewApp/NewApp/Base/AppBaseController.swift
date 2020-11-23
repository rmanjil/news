//
//  BaseController.swift
//  TheNews
//
//  Created by manjil on 11/8/20.
//

import UIKit
import BaseDesignFramework

typealias AlertHandler = ((UIAlertAction) -> Swift.Void)?

class AppBaseController: BaseController {
    override func viewDidLoad() {
        super.viewDidLoad()
        observeEvent()
    }
    
    func observeEvent() {}
}
