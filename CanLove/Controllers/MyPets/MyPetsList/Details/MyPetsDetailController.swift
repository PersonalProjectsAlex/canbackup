//
//  MyPetsDetailController.swift
//  CanLove
//
//  Created by Alex on 13/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit

class MyPetsDetailController: UIViewController {
    
    // MARK: - Let-Var
    var selectedDog:MyDog?
    
    // MARK: - Outlets
    @IBOutlet weak var namePetLabel: UILabel!
    @IBOutlet weak var personalityLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // setting up general actions/delegates/Core
        setUpActions()
        
        // setting up UI elements to be used through the code
        setUpUI()
        
        //Setting data
        settingData()
        
    }
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segues.mypets.detailMyPetsToEditPetController {
            let detailController = segue.destination as! EditPetController
            detailController.selectedDog = selectedDog
        }
    }
    
    // MARK: - SetUps / Funcs
    func setUpUI(){
        //Separator color at tableview
        commentsTableView.separatorColor = .clear
    }
    
    func setUpActions(){
        //Tableview Delegate
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        
        //Set Cell Identifier
        Core.shared.registerCell(at: commentsTableView, named: K.cellsIdentifiers.table.userCommentsTableCell)
    }
    
    private func settingData(){
        guard let dog = selectedDog else{return}
        namePetLabel.text = dog.name
        guard let personality = dog.canineProfile?.personality else{return}
        personalityLabel.text = personality
        guard let weight = dog.weight?.description else{return}
        weightLabel.text = "\(weight) lbs."
        guard let height = dog.dogBreed?.breedSize else{return}
        heightLabel.text = height
        guard let breed = dog.dogBreed?.breedName else{return}
        breedLabel.text = breed
        guard let vaccine = dog.isValidVaccineChart else{return}
        stateLabel.text = !vaccine ? "Pendiente" : "Aprobado"
        stateLabel.textColor =  !vaccine ? #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1) :  #colorLiteral(red: 0.1373712122, green: 0.345433712, blue: 0.4244714379, alpha: 1)
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editAction(_ sender: UIButton) {
        performSegue(withIdentifier: K.segues.mypets.detailMyPetsToEditPetController, sender: self)
    }
    
    
    // MARK: - Objective C

}
