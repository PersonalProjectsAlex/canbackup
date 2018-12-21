//
//  SetNewWalkThroughController.swift
//  CanLove
//
//  Created by Alex on 14/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMaps

class SetNewWalkThroughController: UIViewController{
    
    
    // MARK: - Let-Var
    
    
    // MARK: - Outlets
    @IBOutlet weak var walksTableView: UITableView!
    @IBOutlet weak var hideView: UIView!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up general actions/delegates/Core
        setUpActions()
        
        // setting up UI elements to be used through the code
        setUpUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let isNewPet = Singleton.shared.checkisBool(key: K.defaultKeys.others.isNewPet)
        
        if isNewPet{
            DispatchQueue.main.async {
                Singleton.shared.removeDefault(toRemove: K.defaultKeys.others.isNewPet)
                self.tabBarController?.selectedIndex = 2
            }
        }
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
    
    
     // MARK: - Button action
   
    @IBAction func startWalkthroughAction(_ sender: UIButton) {
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        let alert = Core.shared.createActionsheet(title: "", message: "")
        let quick = UIAlertAction(title: K.titles.actionSheet.quick, style: .default, handler: {
            action in
            weak.performSegue(withIdentifier: K.segues.startWalkthrough.startWalkthroughToScheduleWalkThrough, sender: nil)
        })
        quick.setValue( #colorLiteral(red: 0.1373712122, green: 0.345433712, blue: 0.4244714379, alpha: 1), forKey: "titleTextColor")
        alert.addAction(quick)
        
        let programmed = UIAlertAction(title: K.titles.actionSheet.programmed, style: .default, handler: {
            action in
            //weak.performSegue(withIdentifier: K.segues.startWalkthrough.startWalkthroughToScheduleWalkThrough, sender: nil)
        })
        programmed.setValue( #colorLiteral(red: 0.1373712122, green: 0.345433712, blue: 0.4244714379, alpha: 1), forKey: "titleTextColor")
        alert.addAction(programmed)
        
        let cancel = UIAlertAction(title: K.titles.actionSheet.cancel, style: .cancel, handler: nil)
        cancel.setValue( #colorLiteral(red: 0.3411764706, green: 0.3411764706, blue: 0.3411764706, alpha: 1), forKey: "titleTextColor")
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    
     // MARK: - Objective C
}
