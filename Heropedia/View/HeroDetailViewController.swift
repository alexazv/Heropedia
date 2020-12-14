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
    
    private var viewModel: HeroDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setup(heroId: Int) {
        viewModel = HeroDetailViewModel(heroId: heroId, bindToViewController: updateViews)
    }
    
    func updateViews() {
        heroTitle?.text = viewModel?.hero?.name
        heroDescription?.text = viewModel?.heroDescription

        guard let url = viewModel?.hero?.imageUrl else {
            image?.image = nil
            return
        }

        image?.af.setImage(withURL: url)
    }
}
