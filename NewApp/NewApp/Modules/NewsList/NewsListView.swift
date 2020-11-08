//
//  NewsListView.swift
//  TheNews
//
//  Created by manjil on 11/8/20.
//

import UIKit

protocol ArticleSelection: class {
    func selectedArticle(article: Article)
}

class ArticleCell:UITableViewCell {
    
    lazy var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        //   imageView.image = #imageLiteral(resourceName: "Logo")
        return imageView
    }()
    
    lazy var readFullButton: UIButton = {
        let button = UIButton()
        button.setTitle("Read more article", for: .normal)
        button.layer.cornerRadius = 20
        button.contentHorizontalAlignment = .right
        button.semanticContentAttribute = .forceRightToLeft
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        return button
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: ArticleSelection?
    
    var articleModel: Article! {
        didSet {
            configureCell()
        }
    }
    
    private func  setUpCell()  {
        contentView.backgroundColor = .clear
        contentView.addSubview(articleImageView)
        contentView.addSubview(label)
        
        contentView.addSubview(readFullButton)
        
        
        /// contraint image
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalTo: articleImageView.widthAnchor, multiplier: 9 / 16),
        ])
        
        /// constraint label
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        ///  constraint button
        NSLayoutConstraint.activate([
            readFullButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4),
            readFullButton.heightAnchor.constraint(equalToConstant: 40),
            readFullButton.widthAnchor.constraint(equalToConstant: 170),
            readFullButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            readFullButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        readFullButton.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
    }
    
    private func configureCell() {
        let text = "\(articleModel.title)" + "\n\n" + "\(articleModel.content)"
        let firstRange = (text as NSString).range(of: articleModel.title)
        let secondRange = (text as NSString).range(of: articleModel.content)
        
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttributes([.foregroundColor: UIColor.black, .font: UIFont.boldSystemFont(ofSize: 19)], range: firstRange)
        attributeString.addAttributes([.foregroundColor: UIColor.gray, .font: UIFont.systemFont(ofSize: 14) ], range: secondRange)
        label.attributedText = attributeString
        
        imageView?.setImage(string: "https://example.com/image.png")
    }
    
    @objc private func actionButton() {
        delegate?.selectedArticle(article: articleModel)
    }
}
class NewsListView: Baseview {
    lazy var tableView: BaseTable = {
        let tableView = BaseTable(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.registerCell(ArticleCell.self)
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()
    

    
    override func createDesign() {
        super.createDesign()
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

