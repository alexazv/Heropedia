//
//  ViewController.swift
//  HeroClub
//
//  Created by Alexandre Azevedo on 12/13/20.
//

import UIKit

class HeroFeedViewController: UIViewController, StoryBoarded, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView?
    weak var coordinator: MainCoordinator?
    var number: Int?
    
    private var viewModel: HeroFeedViewModel?
    private let reuseIdentifier = "HeroCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel = HeroFeedViewModel(bindToViewController: onViewModelUpdate)
    }
    
    private func onViewModelUpdate() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    private func onItemClick(index: Int) {
        guard let heroId = viewModel?.heroes?[index].heroId else { return }
        coordinator?.goToDetails(heroId: heroId)
    }
    
    // MARK: Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.heroes?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HeroCollectionViewCell
        cell.setup(hero: viewModel?.heroes?[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onItemClick(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        onItemClick(index: indexPath.item)
    }
}

