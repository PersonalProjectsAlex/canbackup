//
//  CardsTableCell.swift
//  CanLove
//
//  Created by Alex on 12/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit

class CardsTableCell: UITableViewCell {

    // MARK: - Didset
    var setCards: Card?{
        didSet {
            setupCell()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var cardNumberLabel: UILabel!
    
    
    // MARK: - Let-Var
   
    
    ///Cleaning
    override func prepareForReuse() {}
    
    func setupCell(){
        guard let card = setCards else{return}
        cardNumberLabel.text = card.friendlyCard
    }
}
