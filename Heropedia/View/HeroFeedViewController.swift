//
//  ViewController.swift
//  HeroClub
//
//  Created by Alexandre Azevedo on 12/13/20.
//

import UIKit

class HeroFeedViewController: UIViewController, StoryBoarded, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var loadingView: UIView?
    
    weak var coordinator: MainCoordinator?
    
    private var viewModel: HeroFeedViewModel?
    private let reuseIdentifier = "HeroCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel = HeroFeedViewModel(bindToViewController: onViewModelUpdate, bindLoadingChange: updateLoadingView)
    }
    
    private func onViewModelUpdate() {
        updateErrorView()
        updateList()
    }
    
    private func updateLoadingView() {
        loadingView?.isHidden = !(viewModel?.loading ?? false)
    }
    
    private func updateList() {
        guard let count = self.viewModel?.heroes.count,
              let lastCount = self.viewModel?.lastCount,
              count > lastCount else {
            return
        }
        
        let indexPaths = (lastCount..<count).map { IndexPath(row: $0, section: 0) }
        
        collectionView?.performBatchUpdates({
            self.collectionView?.insertItems(at: indexPaths)
        })
    }
    
    private func updateErrorView() {
        guard viewModel?.error != nil else {
            return
        }
        
        let alert = UIAlertController(title: "Error", message: viewModel?.errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler:  { _ in
            self.viewModel?.onErrorConfirm()
        }))
        self.present(alert, animated: true)
    }
    
    private func onItemClick(index: Int) {
        guard let heroId = viewModel?.heroes[index].heroId else { return }
        coordinator?.goToDetails(heroId: heroId)
    }
    
    // MARK: Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.heroes.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HeroCollectionViewCell
        cell.setup(hero: viewModel?.heroes[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onItemClick(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        onItemClick(index: indexPath.item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard let collectionView = self.collectionView,
              scrollView.contentOffset.y > collectionView.contentSize.height - scrollView.frame.height else {
            return
        }
        
        viewModel?.onReachEnd()
    }
}

