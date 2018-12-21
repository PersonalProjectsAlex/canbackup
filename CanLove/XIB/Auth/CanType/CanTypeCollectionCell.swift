//
//  CanTypeCollectionCell.swift
//  CanLove
//
//  Created by Alex on 26/10/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import SDWebImage
import HexColors

class CanTypeCollectionCell: UICollectionViewCell {

    // MARK: - Didset
    var setBreed: ListBreed?{
        didSet {
            setupCell()
            
        }
    }
    
    // MARK: - Let-Var
    
    // MARK: - Outlets
    @IBOutlet weak var canImageView: UIImageView!
    @IBOutlet weak var selectedImageView: RoundedImageView!
    @IBOutlet weak var breedNameLabel: UILabel!
    
    
    // MARK: - SetUps / Funcs
    func setupCell(){
        guard let breed = setBreed else{return}
        breedNameLabel.text = breed.name
        canImageView.sd_setImage(with: URL(string: breed.cover), placeholderImage: #imageLiteral(resourceName: "perro"))
        
    }
   
    
    override var isSelected: Bool{
        didSet{
            //canImageView.backgroundColor = !isSelected ? .clear : .blue
            canImageView.layer.borderColor = !isSelected ? UIColor.clear.cgColor : #colorLiteral(red: 0.1373712122, green: 0.345433712, blue: 0.4244714379, alpha: 1)
            canImageView.layer.borderWidth = !isSelected ? 0 : 1.8
            selectedImageView.isHidden = !isSelected ? true : false
            
        }
    }

}
