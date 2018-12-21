//
//  MeetYourPeetController.swift
//  CanLove
//
//  Created by Alex on 31/10/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit

class MeetYourPeetController: UIViewController {

    // MARK: - Let-Var
    
    //--Coming from segue
    var newPet:NewPet?
    var isNewFromMypet = false
    
    // MARK: - Outlets
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segues.auth.meetYourPetToQuizController {
            let detailController = segue.destination as! QuizController
            detailController.isNewFromMypet = isNewFromMypet
        }
        
    }
    
    
    // MARK: - SetUps / Funcs
    @IBAction func goToQuizAction(_ sender: UIButton) {
        performSegue(withIdentifier: K.segues.auth.meetYourPetToQuizController, sender: nil)
    }
    
}
