//
//  Baseview.swift
//  TheNews
//
//  Created by manjil on 11/8/20.
//

import UIKit
import BaseDesignFramework


class AppBaseView: BaseView {
    
    lazy var indicatorView: UIActivityIndicatorView  = {
       let indictor = UIActivityIndicatorView()
        indictor.hidesWhenStopped = true
        indictor.style = .large
        indictor.color = .black
        indictor.translatesAutoresizingMaskIntoConstraints = false
        return indictor
    }()
    
    private lazy var freezerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    public var indicate: Bool = false {
        didSet {
            indicate ? addIndicator() : removeIndicator()
        }
    }

    private func addIndicator() {
        addSubview(indicatorView)
        NSLayoutConstraint.activate([
            indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        bringSubviewToFront(indicatorView)
        indicatorView.startAnimating()
    }
    
    private func removeIndicator() {
        indicatorView.removeConstraints(indicatorView.constraints)
        indicatorView.removeFromSuperview()
        indicatorView.stopAnimating()
        
    }
}

