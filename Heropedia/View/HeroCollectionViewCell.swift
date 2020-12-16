//
//  HeroCollectionViewCell.swift
//  HeroClub
//
//  Created by Alexandre Azevedo on 12/13/20.
//

import UIKit
import AlamofireImage

class HeroCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView?
    @IBOutlet weak var label: UILabel?
    
    func setup(hero: Hero?) {
        label?.text = hero?.name
        
        image?.image = nil
        guard let url = hero?.imageUrl else {
            return
        }
        
        image?.af.setImage(withURL: url)
    }
}
