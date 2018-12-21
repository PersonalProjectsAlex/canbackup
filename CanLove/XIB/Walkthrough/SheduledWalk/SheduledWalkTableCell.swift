//
//  SheduledWalkTableCell.swift
//  CanLove
//
//  Created by Alex on 6/12/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit

class SheduledWalkTableCell: UITableViewCell {
    
    // MARK: - Didset
    var setScheduledWalk: Answer?{
        didSet {
            setupScheduledWalk()
        }
    }
    
    var setAcceptedWalk: Answer?{
        didSet {
            setupScheduledWalk()
        }
    }
    
    
    // MARK: - Outlets
    @IBOutlet weak var leftview: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    var isGoing = Bool()
    
    // MARK: - LifeCycles
    override func awakeFromNib() {
        leftview.backgroundColor = isGoing ? #colorLiteral(red: 1, green: 0.8943250775, blue: 0, alpha: 1) : #colorLiteral(red: 0.5667611957, green: 0.5667749643, blue: 0.5667675734, alpha: 1)
    }
    
    // MARK: -Functions
    
    func setupScheduledWalk(){
    
    }
    
    func setupAccepedWalk(){
        //-Design
        
    }
    
}
