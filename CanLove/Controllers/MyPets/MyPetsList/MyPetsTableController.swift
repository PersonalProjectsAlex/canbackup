//
//  MyPetsController.swift
//  CanLove
//
//  Created by Alex on 9/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import Alamofire
import TableFlip


class MyPetsTableController: UIViewController {
    
    // MARK: - Let-Var
    //--Header
    open var header: HTTPHeaders{
        let token = Singleton.shared.checkValueSet(key: K.defaultKeys.auth.accessToken)
        let bearer = Core.shared.setBearerToken(token)
        return ["Authorization": bearer]
    }
    
    var myDogs = MyDogs()
    var selectedDog:MyDog?
    var isNewFromMypet = true
    
    // MARK: - Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var myPetsTableView: UITableView!
    
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
        if segue.identifier == K.segues.mypets.myPetToMyPetDetailController {
            let detailController = segue.destination as! MyPetsDetailController
            detailController.selectedDog = selectedDog
        }
        
        if segue.identifier == "prueba" {
            let detailController = segue.destination as! SelectProfileImageController
            detailController.isNewFromMypet = isNewFromMypet
        }
    }
    
    // MARK: - SetUps / Funcs
    func setUpUI(){
        //Tableview separator color
        myPetsTableView.separatorColor = .clear
    }
    
    func setUpActions(){
        //Tableview Delegate
        myPetsTableView.delegate = self
        myPetsTableView.dataSource = self
        
        //Set Cell Identifier
        Core.shared.registerCell(at: myPetsTableView, named: K.cellsIdentifiers.table.myPetsTableCell)
    }
    
    private func gettingData(){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        myDogs.removeAll()
        myPetsTableView.reloadData()
        activityIndicator.startAnimating()
        DogManager().getDogs(header: header) {
            dogs in
            guard let dogs = dogs else{
                weak.activityIndicator.stopAnimating()
                return
            }
           
           
            weak.myDogs = dogs
            
            if weak.myDogs.count > 0{
                weak.myPetsTableView.reloadData()
                weak.activityIndicator.stopAnimating()
                weak.animateTableView()
            }else{
                weak.activityIndicator.stopAnimating()
            }
        }
    }
    
    func animateTableView(){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        let customAnimation = TableViewAnimation.Cell.left(duration: 0.5)
        weak.myPetsTableView.animate(animation: customAnimation, completion: nil)
    }
    
    @IBAction func addPetAction(_ sender: UIButton) {
        performSegue(withIdentifier: "prueba", sender: self)
    }
    // MARK: - Objective C
 

}
