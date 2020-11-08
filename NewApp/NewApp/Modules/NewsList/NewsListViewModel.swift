//
//  NewsListViewModel.swift
//  TheNews
//
//  Created by manjil on 11/8/20.
//

import Foundation


class NewsListViewModel: BaseViewModel {
    
    let manager: NewsManager
    
    override init() {
       manager = NewsManager()
    }
    
    func callApi() {
        let parameter = ["country": "us"]
        manager.request(router: NewsRouter.headline(parameter))
    }
}
