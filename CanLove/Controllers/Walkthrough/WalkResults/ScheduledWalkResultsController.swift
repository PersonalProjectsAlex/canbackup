//
//  ScheduledWalkResultsController.swift
//  CanLove
//
//  Created by Alex on 6/12/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit

class ScheduledWalkResultsController: UIViewController {
    
    // MARK: - Let-Var
    
    // MARK: - Outlets
    @IBOutlet weak var walksTableView: UITableView!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up general actions/delegates/Core
        setUpActions()
        
        // setting up UI elements to be used through the code
        setUpUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    // MARK: - SetUps / Funcs
    func setUpUI(){}
    
    func setUpActions(){
        //Tableview Delegate
        walksTableView.delegate = self
        walksTableView.dataSource = self
        
        //Set Cell Identifier
        Core.shared.registerCell(at: walksTableView, named: K.cellsIdentifiers.table.scheduledWalk)

    }
    
    private func gettingData(){}
    
    // MARK: - Objective C
    

}
