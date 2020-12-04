//
//  BaseTable.swift
//  TheNews
//
//  Created by manjil on 11/8/20.
//

import UIKit
class EmptyView: UIView {
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Nothing to display"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        generateView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func generateView() {
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 8)
            
        ])
    }
}

class BaseTable: UITableView {
    
    lazy var emptyView: EmptyView = {
        EmptyView()
    }()
    
    var hideLabel = true  {
        didSet {
            emptyView.label.isHidden = hideLabel
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        backgroundView = emptyView
        emptyView.label.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

