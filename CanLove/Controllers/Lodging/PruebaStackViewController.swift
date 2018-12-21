//
//  PruebaStackViewController.swift
//  CanLove
//
//  Created by Alex on 13/12/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import DLRadioButton

class PruebaStackViewController: UIViewController{
    
    @IBOutlet weak var stack: UIStackView!
    let array = ["dfsdf", "dfsdf", "Alex"]
    var otherButtons : [DLRadioButton] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stack.distribution = .fillEqually
        stack.spacing = 50
        
        
        for view in self.stack.arrangedSubviews {
            self.stack.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        for  (position,service) in array.enumerated(){
            
            let view: PaymentRow = UIView.fromNib()
            view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 45)
            view.optionButton.isSelected = false
            view.optionButton.setTitle(service, for: .normal)
            view.optionButton.tag = position
            view.optionButton.isSelected = false
            otherButtons.append(view.optionButton)
            
            view.optionButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
            
            self.stack.addArrangedSubview(view.optionButton)
            self.view.setNeedsLayout()
        }
        self.view.layoutIfNeeded()

    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @objc func buttonClicked(_ sender: DLRadioButton?) {
        for i in otherButtons{
            i.isSelected = false
            if i.tag == sender?.tag{
                sender!.isSelected = true
                print(sender?.tag)
            }
        }
        
       
    }

 
}
