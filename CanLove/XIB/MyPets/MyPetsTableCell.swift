//
//  MyPetsTableCell.swift
//  CanLove
//
//  Created by Alex on 9/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import SDWebImage

class MyPetsTableCell: UITableViewCell {

    // MARK: - Didset
    var setDog: MyDog?{
        didSet {
            setupCell()
        }
    }

    // MARK: - Let-Var
    
    // MARK: - Outlets
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    ///Cleaning
    override func prepareForReuse() {}
    
    func setupCell(){
        guard let dog = setDog else{return}
        nameLabel.text = dog.name
    }
    
}
