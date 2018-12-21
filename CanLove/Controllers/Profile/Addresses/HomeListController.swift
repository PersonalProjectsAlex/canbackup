//
//  HomeListController.swift
//  CanLove
//
//  Created by Alex on 26/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit

class HomeListController: UIViewController {
    
    // MARK: - Let-Var
    
    // MARK: - Outlets
    @IBOutlet weak var homeEmptyStateView: UIView!
    @IBOutlet weak var addressesTableView: UITableView!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up general actions/delegates/Core
        setUpActions()
        
        // setting up UI elements to be used through the code
        setUpUI()
    }
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    // MARK: - SetUps / Funcs
    
    func setUpUI(){}
    
    func setUpActions(){
        //Tableview Delegate
//        addressesTableView.delegate = self
//        addressesTableView.dataSource = self
        
        //Set Cell Identifier
        Core.shared.registerCell(at: addressesTableView, named: K.cellsIdentifiers.table.addressesTableCell)
        
    }
    
    private func gettingData(){}
    
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Objective C
    
    
    

}
