//
//  HeroFeedViewModel.swift
//  Heropedia
//
//  Created by Alexandre Azevedo on 12/13/20.
//

import Foundation

class HeroFeedViewModel {
    var bindToViewController: (() -> Void) = {}
    private var dataSource: HeroDataSource = HeroAPISource()
    private (set) var error: Error?
    private (set) var heroes: [Hero]?
    
    init(bindToViewController: @escaping () -> Void) {
        self.bindToViewController = bindToViewController
        fetch()
    }
    
    func fetch() {
        dataSource.getItems() { (heroes, error) in
            self.heroes = heroes
            self.error = error
            self.bindToViewController()
        }
    }
}
