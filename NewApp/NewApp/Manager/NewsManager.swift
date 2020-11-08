//
//  NewsManager.swift
//  TheNews
//
//  Created by manjil on 11/8/20.
//

import Foundation
import Combine

typealias Paramters = [String: Any]
class NewsManager {
    var bag = Set<AnyCancellable>()
    @Published var articles: [Article] = []
    let isApicall = PassthroughSubject<Bool,Never>()
    let networking = Networking()
    
    func request(router: Routable) {
        isApicall.send(true)
        networking.request(router: router).sink { [weak self] result in
            guard let self = self else {  return }
            self.isApicall.send(false)
            self.parseResult(result: result, router: router)
        }.store(in: &bag)
    }
    
    
    private func parseResult(result: NetworkingResult, router: Routable)  {
        switch router {
        case NewsRouter.headline:
            if !result.object.isEmpty,
               let articleJson = result.object["articles"] as? [Paramters]
            {
                let articles = DataMapper<Article>.arrayMapping(articleJson)
                print(articles)
                self.articles =  articles
            }
            break
        default:
            break
        }
        
    }
}
