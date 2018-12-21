//
//  PaymentRow.swift
//  CanLove
//
//  Created by Alex on 13/12/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import DLRadioButton

class PaymentRow: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet var lblLastName: UILabel!
    @IBOutlet weak var optionButton: DLRadioButton!
    var onClickCallback: (() -> Void)?
    
    @IBAction func paymentActionButton(_ sender: DLRadioButton) {
        onClickCallback?()
    }
    
}


