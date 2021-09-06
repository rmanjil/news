//
//  AppCoordinator .swift
//  NewApp
//
//  Created by manjil on 11/24/20.
//

import Foundation
import BaseDesignFramework
import Combine

enum AuthRoute: AppRoutable {
    case login
    case forgotPassword
}

final class  AppCoordinator: BaseCoordinator {
    let route: Route
    var bag = Set<AnyCancellable>()
    init(route: Route) {
        self.route = route
    }
    
    override func start(with deepLink: DeepLink?) {
        redirectScreen()
    }
    
    private func redirectScreen() {
       if   UserData.get == nil {
            openLanding()
       } else {
        openArticalList()
       }
    }
    
    private func openArticalList() {
        let view = NewsListView()
        let viewModel = NewsListViewModel()
        let controller = NewsListController(baseView: view, baseViewModel: viewModel)
        
        viewModel.trigger.receive(on: RunLoop.main).sink { [weak self] trigger in
            guard let self = self else { return }
            self.handleTrigger(route: trigger)
        }.store(in: &bag)
        
        route.setRoot(presentable: controller)
    }
    
    private func openArticleDetail(article: Article) {
        let viewModel = ArticleDetailViewModel(article: article)
        let controller = ArticleDetailController(baseView: ArticleDetailView(), baseViewModel: viewModel)
        
        route.push(presentable: controller)
    }
    
    
    private func openLanding() {
        let viewModel = LandingViewModel()
        let controller = LandingController(baseView: LandingScreen(), baseViewModel: viewModel)
        viewModel.trigger.receive(on: RunLoop.main).sink { [weak self] trigger in
            guard let self = self else { return }
            self.handleTrigger(route: trigger)
        }.store(in: &bag)
        route.setRoot(presentable: controller, hideBar:  true)
    }
    
}

extension AppCoordinator {
    private func handleTrigger(route: AppRoutable) {
        switch route {
        case AppRoute.articleDetail(article: let article):
            openArticleDetail(article: article)
        case AppRoute.finish:
            redirectScreen()
        default:
            break
        }
    }
}
