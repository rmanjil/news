//
//  ArticleDetailView.swift
//  NewApp
//
//  Created by manjil on 11/8/20.
//

import UIKit
import WebKit

enum FontSize: CGFloat {
    case size12 = 12.0
    case size15 = 15.0
    case size16 = 16.0
    case size17 = 17.0
    case size18 = 18.0
    case size19 = 19.0
    
}

class BaseLabel: UILabel {
    
    var fontSize: FontSize =  .size16 {
        didSet {
            font = .systemFont(ofSize: fontSize.rawValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        font = .systemFont(ofSize: FontSize.size16.rawValue)
    }
}

class ArticleDetailView: Baseview {
    
    
    
    lazy var webView: WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func createDesign() {
        super.createDesign()
        
        addSubview(webView)
        ///  constraint button
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            webView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            webView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            webView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}
