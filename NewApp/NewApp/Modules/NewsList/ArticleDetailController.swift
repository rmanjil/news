//
//  ArticleDetailController.swift
//  NewApp
//
//  Created by manjil on 11/8/20.
//

import UIKit
import WebKit


class ArticleDetailViewModel: BaseViewModel {
    let article: Article
    
    init(article: Article) {
        self.article = article
    }
}
class ArticleDetailController: BaseController {

    var screenView: ArticleDetailView {
        baseView as! ArticleDetailView
    }
    
    var viewModel: ArticleDetailViewModel {
        baseViewModel as!  ArticleDetailViewModel
    }
    
  
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenView.webView.navigationDelegate = self
        title =  "Article Detail"
        loadData()
        // Do any additional setup after loading the view.
    }
    
    private func loadData() {
        if let url = URL(string: viewModel.article.url) {
            screenView.indicate = true
            screenView.webView.load(URLRequest(url: url))
        }
        
    }
}

extension ArticleDetailController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //self.customView.indicator.stopAnimating()
       // showIndicator(isTrue: false)
        screenView.indicate = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
       // showIndicator(isTrue: false)
        screenView.indicate = false
    }
}
