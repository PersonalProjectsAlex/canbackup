//
//  CardsTableController.swift
//  CanLove
//
//  Created by Alex on 12/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import Stripe
import Alamofire

class CardsTableController: UIViewController {
    // MARK: - Let-Var
    
        //--Header
    open var header: HTTPHeaders{
        let token = Singleton.shared.checkValueSet(key: K.defaultKeys.auth.accessToken)
        let bearer = Core.shared.setBearerToken(token)
        return ["Authorization": bearer]
    }
    var cards = Cards()
    
    // MARK: - Outlets
    @IBOutlet weak var cardsTableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
 
    
    // MARK: - SetUps / Funcs
    func setUpUI(){
        //Separate color on tableview
        cardsTableView.separatorColor = .clear
    }
    
    func setUpActions(){
        //Tableview Delegate
        cardsTableView.delegate = self
        cardsTableView.dataSource = self
  
        
        //Set Cell Identifier
        Core.shared.registerCell(at: cardsTableView, named: K.cellsIdentifiers.table.cardsTableCell)
    }
    
    func gettingData(){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        cards.removeAll()
        cardsTableView.reloadData()
        indicator.startAnimating()
        
        UserManager().getCards(header: header) {
            cards in
            guard let cards = cards else{return}
            weak.cards = cards
            if weak.cards.count > 0{
                weak.indicator.stopAnimating()
                weak.cardsTableView.reloadData()
            }
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Objective C
    

}
