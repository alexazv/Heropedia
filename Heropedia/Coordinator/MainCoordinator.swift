//
//  MainCoordinator.swift
//  Heropedia
//
//  Created by Alexandre Azevedo on 12/13/20.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HeroFeedViewController.instantiate()
        viewController.coordinator = self
        viewController.number = 2
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func goToDetails(heroId: Int) {
        let viewController = HeroDetailViewController.instantiate()
        viewController.setup(heroId: heroId)
        navigationController.pushViewController(viewController, animated: true)
    }
}
