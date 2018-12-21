//
//  QuickWalkthroughController.swift
//  CanLove
//
//  Created by Alex on 18/12/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import Alamofire
import DLRadioButton

class QuickWalkthroughController: UIViewController {

    // MARK: - Let-Var
    //--Header
    open var header: HTTPHeaders{
        let token = Singleton.shared.checkValueSet(key: K.defaultKeys.auth.accessToken)
        let bearer = Core.shared.setBearerToken(token)
        return ["Authorization": bearer]
    }
    
    var myDogs = MyDogs()
    var selectedDog:MyDog?
    
    let locale = Locale(identifier: "es_GT")
    let array = ["dfsdf", "dfsdf", "Alex"]
     var otherButtons : [DLRadioButton] = [];
    var cards = Cards()
    
    // MARK: - Outlets
    @IBOutlet weak var petsCollectionView: UICollectionView!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var cashButton: DLRadioButton!
    
    
    //-Height Constraint
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up general actions/delegates/Core
        setUpActions()
        
        // setting up UI elements to be used through the code
        setUpUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        gettingData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    
    // MARK: - SetUps / Funcs
    
    func setUpUI(){
        //Stackview
        stack.distribution = .fillEqually
        stack.spacing = 50
        
        //Background on button
        cashButton.subviews.first?.contentMode = .scaleAspectFill
    }
    
    func setUpActions(){
        petsCollectionView.delegate = self
        petsCollectionView.dataSource = self
        
        //Set Cell Identifier
        Core.shared.registerCellCollection(at: petsCollectionView, named: K.cellsIdentifiers.collection.choosePetCollectionCell)
        
       
        
    }
    
    private func gettingData(){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        myDogs.removeAll()
        
        DogManager().getDogs(header: header) {
            dogs in
            guard let dogs = dogs else{
                //weak.activityIndicator.stopAnimating()
                return
            }
            print(dogs)
            weak.myDogs = dogs
            
            if weak.myDogs.count > 0{
                weak.petsCollectionView.reloadData()
            }
        }
        
        
        cards.removeAll()
        UserManager().getCards(header: header) {
            cards in
            guard let cards = cards else{return}
            weak.cards = cards
            if weak.cards.count > 0{
                weak.setCards()
            }
        }
    }
    
    
    func setCards(){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        for view in self.stack.arrangedSubviews {
            self.stack.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        for  (position,card) in cards.enumerated(){
            
            let view: PaymentRow = UIView.fromNib()
            view.frame = CGRect(x: 0, y: 0, width: weak.view.frame.width, height: 45)
            view.optionButton.isSelected = false
            view.optionButton.layoutIfNeeded()
            view.optionButton.subviews.first?.contentMode = .scaleAspectFill
            view.optionButton.setTitle("             \(card.friendlyCard)", for: .normal)
            view.optionButton.tag = position
            view.optionButton.isSelected = false
            otherButtons.append(view.optionButton)
            
            view.optionButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
            
            weak.stack.addArrangedSubview(view.optionButton)
            weak.view.setNeedsLayout()
        }
        weak.view.layoutIfNeeded()
    }
    
    
    @IBAction func cashAction(_ sender: DLRadioButton) {
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        if otherButtons.count > 0{
            for i in otherButtons{
                i.isSelected = false
            }
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    // MARK: - Objective C
    @objc func buttonClicked(_ sender: DLRadioButton?) {
        for i in otherButtons{
            i.isSelected = false
            cashButton.isSelected = false
            if i.tag == sender?.tag{
                sender!.isSelected = true
                guard let tag = sender?.tag else{return}
                    print("\(cards[tag].id)")
                
            }
        }
    }
    
}


