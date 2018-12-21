//
//  LodgingDetailsController.swift
//  CanLove
//
//  Created by Alex on 13/12/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit

class LodgingDetailsController: UIViewController {
    
    // MARK: - Let-Var
    
    // MARK: - Outlets
    
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
    
    func setUpActions(){}
    
    private func gettingData(){}
    
    // MARK: - Objective C
    

}
