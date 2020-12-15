//
//  HeroDetailViewModel.swift
//  Heropedia
//
//  Created by Alexandre Azevedo on 12/13/20.
//

import UIKit

class HeroDetailViewModel {
    var bindToViewController: (() -> Void) = {}
    private var dataSource: HeroDataSource = DataSource.heroDataSource()
    private var heroId: Int
    private (set) var error: Error?
    private (set) var hero: HeroDetail?
    var heroSeriesText: String? {
        guard let series = hero?.seriesCount else { return nil }
        return "Appears in \(series) comic series"
    }
    var heroStoriesText: String? {
        guard let stories = hero?.storiesCount else { return nil }
        return "Appears in \(stories) stories"
    }
    private (set) var loading = false {
        didSet {
            bindToViewController()
        }
    }
    
    var errorMessage: String {
        "There was an error retrieving info"
    }
    
    func onErrorConfirm() {
        error = nil
        fetch()
    }
    
    var heroDescription: String? {
        guard let description = hero?.description else { return nil }
        return description.count > 0 ? description : "Description not available"
    }
    
    init(heroId: Int, bindToViewController: @escaping () -> Void) {
        self.bindToViewController = bindToViewController
        self.heroId = heroId
        fetch()
    }
    
    func fetch() {
        guard error == nil && !loading else { return }
        loading = true
        dataSource.getDetail(heroId: heroId) { (hero, error) in
            self.hero = hero
            self.error = error
            self.loading = false
        }
    }
}
