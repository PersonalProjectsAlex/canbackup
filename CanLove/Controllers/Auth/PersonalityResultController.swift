//
//  PersonalityResultController.swift
//  CanLove
//
//  Created by Alex on 8/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit

class PersonalityResultController: UIViewController {
    
    // MARK: - Let-Var
    var isNewFromMypet = false
    
    // MARK: - Outlets
    @IBOutlet weak var typeDogLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var summaryResultLabel: UILabel!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up general actions/delegates/Core
        setUpActions()
        
        // setting up UI elements to be used through the code
        setUpUI()
        
    }
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
 
    
    // MARK: - SetUps / Funcs
    func setUpUI(){}
    
    func setUpActions(){}
    
    private func gettingData(){}
    
    @IBAction func goToMainAction(_ sender: UIButton) {
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        if !isNewFromMypet{
            performSegue(withIdentifier: K.segues.auth.canPersonalityToMainTabBar, sender: self)
        }else{
            DispatchQueue.main.async {
                Singleton.shared.setNewPetState(true)
                let storyboard = UIStoryboard(name: K.storyboards.menu, bundle: nil)
                let view = storyboard.instantiateViewController(withIdentifier: K.instances.mainTabBarController) as! MenuTabBarController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                //show window
                appDelegate.window?.rootViewController = view
            }
        }
        
    }
    
    
    // MARK: - Objective C

}
