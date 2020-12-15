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
        navigationController.navigationBar.barTintColor = UIColor.systemYellow
        navigationController.navigationBar.tintColor = UIColor.black
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HeroFeedViewController.instantiate()
        viewController.coordinator = self
        viewController.title = "Heropedia"
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func goToDetails(heroId: Int) {
        let viewController = HeroDetailViewController.instantiate()
        viewController.title = "Hero Details"
        viewController.setup(heroId: heroId)
        navigationController.pushViewController(viewController, animated: true)
    }
}
