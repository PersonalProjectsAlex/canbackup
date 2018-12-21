//
//  CanSizeCollectionCell.swift
//  CanLove
//
//  Created by Alex on 26/10/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import SDWebImage

class CanSizeCollectionCell: UICollectionViewCell {

    // MARK: - Didset
    var setBreed: BreedElement?{
        didSet {
            setupCell()
        }
    }
    
    
    // MARK: - Let-Var
    
    
    // MARK: - Outlets
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var sizeImageView: UIImageView!
    
    
    // MARK: - SetUps / Funcs
    func setupCell(){
        guard let breed = setBreed else{return}
        
        breedLabel.text = breed.size
        
        switch breed.size {
        case "Toy":
            sizeImageView.image = DogSizeIcon.toy.image
        case "Pequeño":
            sizeImageView.image = DogSizeIcon.small.image
        case "Mediano":
            sizeImageView.image = DogSizeIcon.medium.image
        case "Grande":
            sizeImageView.image = DogSizeIcon.big.image
        case "Gigante":
            sizeImageView.image = DogSizeIcon.huge.image
        default:
            sizeImageView.image = DogSizeIcon.big.image
        }
        
    }

}
