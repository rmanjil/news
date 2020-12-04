//
//  AppCoordinator .swift
//  NewApp
//
//  Created by manjil on 11/24/20.
//

import Foundation
import BaseDesignFramework
import Combine

final class  AppCoordinator: BaseCoordinator {
    let route: Route
    var bag = Set<AnyCancellable>()
    init(route: Route) {
        self.route = route
    }
    
    override func start(with deepLink: DeepLink?) {
      
    }
    
    private func openArticalList() {
        let view = NewsListView()
        let viewModel = NewsListViewModel()
        let controller = NewsListController(baseView: view, baseViewModel: viewModel)
        
        viewModel.trigger.receive(on: RunLoop.main).sink { [weak self] trigger in
            guard let self = self else { return }
        }.store(in: &bag)
        
        route.setRoot(presentable: controller)
    }
}
