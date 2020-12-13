//
//  HeroDetailViewModel.swift
//  Heropedia
//
//  Created by Alexandre Azevedo on 12/13/20.
//

import UIKit

class HeroDetailViewModel {
    var bindToViewController: (() -> Void) = {}
    private var dataSource: HeroDataSource = HeroAPISource()
    private (set) var error: Error?
    private (set) var hero: HeroDetail?
    
    init(heroId: Int, bindToViewController: @escaping () -> Void) {
        self.bindToViewController = bindToViewController
        fetch(heroId: heroId)
    }
    
    func fetch(heroId: Int) {
        dataSource.getDetail(heroId: heroId) { (hero, error) in
            self.hero = hero
            self.error = error
            self.bindToViewController()
        }
    }
}
