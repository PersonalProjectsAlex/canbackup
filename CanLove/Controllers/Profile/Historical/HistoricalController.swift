//
//  HistoricalController.swift
//  CanLove
//
//  Created by Alex on 28/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit

class HistoricalController: UIViewController {
    // MARK: - Let-Var
    
    // MARK: - Outlets
    @IBOutlet weak var walkthroughTableView: UITableView!
    @IBOutlet weak var lodgingTableView: UITableView!
    
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
        walkthroughTableView.delegate = self
        walkthroughTableView.dataSource = self
        lodgingTableView.delegate = self
        lodgingTableView.dataSource = self
        
        
        //Set Cell Identifier
        //Core.shared.registerCell(at: feedTableView, named: K.cells.table.feedTableCell)
    }
    
    private func gettingWalkthrough(){
        
    }
    
    private func gettingLodging(){
        
    }
    
    @IBAction func segementedAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Hola")
        case 1:
            print("Adios")
        default:
            print("")
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: - Objective C
 

}
