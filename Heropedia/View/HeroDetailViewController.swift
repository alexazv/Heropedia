//
//  HeroDetailViewController.swift
//  HeroClub
//
//  Created by Alexandre Azevedo on 12/13/20.
//

import UIKit

class HeroDetailViewController: UIViewController, StoryBoarded {
    
    @IBOutlet weak var heroTitle: UILabel?
    @IBOutlet weak var heroDescription: UILabel?
    @IBOutlet weak var image: UIImageView?
    @IBOutlet weak var loadingView: UIView?
    @IBOutlet weak var heroSeriesText: UILabel?
    @IBOutlet weak var heroStoriesText: UILabel?
    
    private var viewModel: HeroDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setup(heroId: Int) {
        viewModel = HeroDetailViewModel(heroId: heroId, bindToViewController: onViewModelUpdate)
    }
    
    private func onViewModelUpdate() {
        updateErrorView()
        updateViews()
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
    
    func updateViews() {
        
        loadingView?.isHidden = !(viewModel?.loading ?? false)
        
        if(viewModel?.loading ?? false) { return }
        
        heroTitle?.text = viewModel?.hero?.name
        heroDescription?.text = viewModel?.heroDescription
        heroStoriesText?.text = viewModel?.heroStoriesText
        heroSeriesText?.text = viewModel?.heroSeriesText
        
        guard let url = viewModel?.hero?.imageUrl else {
            image?.image = nil
            return
        }

        image?.af.setImage(withURL: url)
    }
}
