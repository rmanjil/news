//
//  NewsListController.swift
//  TheNews
//
//  Created by manjil on 11/8/20.
//

import UIKit
import Combine
import BaseDesignFramework


class NewsListController: AppBaseController {
    
    var screenView: NewsListView {
        baseView as! NewsListView
    }
    
    var viewModel: NewsListViewModel {
        baseViewModel as!  NewsListViewModel
    }
    
    override var showLeftBarButton: Bool {
        get {
            false
        }
        set { }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenView.tableView.delegate = self
        screenView.tableView.dataSource = self
        title = "News HeadLine"
       
        screenView.indicate = true
        viewModel.callApi()
    }
    
    override func observeEvent() {
        viewModel.manager.$articles.receive(on: RunLoop.main).sink { [weak self] _ in
            self?.screenView.tableView.reloadData()
            self?.screenView.indicate = false
        }.store(in: &viewModel.bag)
      
    }
}


extension NewsListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.manager.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ArticleCell.self, for: indexPath)
        cell.articleModel = viewModel.manager.articles[indexPath.row]
        cell.delegate = self
        return cell
        
    }
}

extension NewsListController: ArticleSelection {
    func selectedArticle(article: Article) {
        viewModel.trigger.send(AppRoute.articleDetail(article:  article))
    }
}
