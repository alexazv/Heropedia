//
//  HeroFeedViewModel.swift
//  Heropedia
//
//  Created by Alexandre Azevedo on 12/13/20.
//

import Foundation

class HeroFeedViewModel {
    var bindToViewController: (() -> Void) = {}
    private var dataSource: HeroDataSource = DataSource.heroDataSource()
    private (set) var error: Error?
    private (set) var heroes: [Hero] = [] {
        didSet {
            lastCount = oldValue.count
            if heroes.count > 0 { page += 1 }
        }
    }
    private (set) var lastCount = 0
    private (set) var loading = false {
        didSet {
            self.bindToViewController()
        }
    }
    var errorMessage: String {
        "There was an error retrieving info"
    }
    
    private var page = 0
    private var hasMore = true;
    
    init(bindToViewController: @escaping () -> Void) {
        self.bindToViewController = bindToViewController
        fetch()
    }
    
    func onReachEnd() {
        fetch()
    }
    
    func onErrorConfirm() {
        error = nil
        fetch()
    }
    
    private func fetch() {
        guard hasMore, error == nil && !loading else { return }
        loading = true
        dataSource.getItems(page: page) { heroes, error, hasMore in
            self.error = error
            
            if let heroes = heroes {
                self.heroes.append(contentsOf: heroes)
                self.hasMore = hasMore
            }
            
            self.loading = false
        }
    }
}
