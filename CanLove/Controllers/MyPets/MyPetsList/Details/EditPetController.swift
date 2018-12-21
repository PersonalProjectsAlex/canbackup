//
//  EditPetController.swift
//  CanLove
//
//  Created by Alex on 14/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class EditPetController: UIViewController {
    
    // MARK: - Let-Var
    //--Header
    open var header: HTTPHeaders{
        let token = Singleton.shared.checkValueSet(key: K.defaultKeys.auth.accessToken)
        let bearer = Core.shared.setBearerToken(token)
        return ["Authorization": bearer]
    }
    
    var selectedDog:MyDog?
    
    // MARK: - Outlets
    @IBOutlet weak var canNameTextField: UITextField!{
        didSet {
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            canNameTextField.leftView = leftView
            canNameTextField.leftViewMode = .always
        }
    }
    
    @IBOutlet weak var poundsTextField: UITextField!{
        didSet {
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            poundsTextField.leftView = leftView
            poundsTextField.leftViewMode = .always
        }
    }
    
    @IBOutlet weak var primerImageView: UIImageView!
    
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
    
    // FIXME: Pass the model updated about a pet when the user goes back
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // TODO:  Pass the model updated about a pet when the user goes back
        
    }
    
    
    // MARK: - SetUps / Funcs
    func setUpUI(){}
    
    func setUpActions(){}
    
    private func settingData(){
        
        guard let dog = selectedDog else{return}
        canNameTextField.text = dog.name
        guard let weight = dog.weight?.description else{return}
        poundsTextField.text = weight
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: - Objective C
    
    
}
