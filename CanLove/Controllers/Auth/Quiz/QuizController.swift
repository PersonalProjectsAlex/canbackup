//
//  QuizController.swift
//  CanLove
//
//  Created by Alex on 31/10/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import Alamofire

class QuizController: UIViewController {
    
    // MARK: - Let-Var
    var index = 0
    var tempIndex = 0
    var totalAnswers:Int?
    var lastSelectedIndexPath:IndexPath?
    var isNewFromMypet = false
    
    //--Header
    open var header: HTTPHeaders{
        let token = Singleton.shared.checkValueSet(key: K.defaultKeys.auth.accessToken)
        let bearer = Core.shared.setBearerToken(token)
        return ["Authorization": bearer]
    }
    
    var selectedQuizResponse = QuizResponse()
    var selectedAnswers = [Answer]()
    
    // MARK: - Outlets
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var quizTableView: UITableView!
    
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up general actions/delegates/Core
        setUpActions()
        
        // Setting up UI elements to be used through the code
        setUpUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        gettingData()
        //--Try out for new state
       //performSegue(withIdentifier: K.segues.auth.quizToResultQuizController, sender: self)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segues.auth.quizToResultQuizController {
            let detailController = segue.destination as! PersonalityResultController
            detailController.isNewFromMypet = isNewFromMypet
        }
        
    }
 
    // MARK: - SetUps / Funcs
    
    func setUpUI(){}
    
    func setUpActions(){
        //Tableview Delegate
        quizTableView.delegate = self
        quizTableView.dataSource = self
        
        //Set Cell Identifier
        Core.shared.registerCell(at: quizTableView, named: K.cellsIdentifiers.table.quizTableCell)
        
    }
    
    private func gettingData(){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        UserManager().questionsQuiz(abb: "QUEST_PROFILE_CAN", header: header) {
            quiz in
            
            guard let quiz = quiz else{return}
            weak.selectedQuizResponse = quiz
            
            
            guard let answers = weak.selectedQuizResponse.first?.answers else{return}
            weak.selectedAnswers = answers
            
            if weak.selectedQuizResponse.count > 0{

                if weak.index == weak.selectedQuizResponse.endIndex {
                     weak.performSegue(withIdentifier: K.segues.auth.quizToResultQuizController, sender: weak)
                }
                
                
                for (idx, element) in weak.selectedQuizResponse.enumerated() {
                    
                    let index = idx
                   let count = weak.selectedQuizResponse.count-1
                    
                    if weak.index == index{
                        
                        weak.selectedAnswers = element.answers
                        weak.questionLabel.text = element.content
                        
                        let indexPerQuestion = idx + 1
                        weak.questionNumberLabel.text = "\(indexPerQuestion) de \(weak.selectedQuizResponse.endIndex.description) "
                        weak.quizTableView.reloadData()
                        
                        
                        
                    }
                    
                }
            }
           

            
        }
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        
        guard let indexLast = lastSelectedIndexPath else {
            Core.shared.alert(message: "Debes seleccionar una de las opciones", title: K.titles.alertWrongTitle, at: self)
            return
        }
        
        index += 1
        gettingData()
        lastSelectedIndexPath = nil
    }
    
    
    // MARK: - Objective C

}
