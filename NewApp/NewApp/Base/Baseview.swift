//
//  Baseview.swift
//  TheNews
//
//  Created by manjil on 11/8/20.
//

import UIKit



class Baseview: UIView {
    
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        createDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createDesign() {
        backgroundColor = .white
    }

    public func freezeAll() {
        addSubview(freezerView)
        NSLayoutConstraint.activate([
            freezerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            freezerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            freezerView.topAnchor.constraint(equalTo: topAnchor),
            freezerView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    /// This method will remove the freezer view from screen
    public func unFreezeAll() {
        freezerView.removeConstraints(freezerView.constraints)
        freezerView.removeFromSuperview()
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

