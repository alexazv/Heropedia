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
    private (set) var heroes: [Hero] = [] {
        willSet {
            lastCount = heroes.count
        }
        didSet {
            if heroes.count > 0 { page += 1 }
        }
    }
    private (set) var lastCount = 0
    private var page = 0
    private var loading = false
    
    init(bindToViewController: @escaping () -> Void) {
        self.bindToViewController = bindToViewController
        fetch()
    }
    
    func onReachEnd() {
        fetch()
    }
    
    private func fetch() {
        guard !loading else { return }
        loading = true
        dataSource.getItems(page: page) { (heroes, error) in
            self.error = error
            
            if let heroes = heroes {
                self.heroes.append(contentsOf: heroes)
            }
            self.bindToViewController()
            self.loading = false
        }
    }
}
