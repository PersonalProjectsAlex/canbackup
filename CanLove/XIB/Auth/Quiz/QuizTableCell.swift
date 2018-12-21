//
//  QuizTableCell.swift
//  CanLove
//
//  Created by Alex on 31/10/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import DLRadioButton

protocol QuizButtonActionDelegate{
    func quizAction(at index:IndexPath)
}

class QuizTableCell: UITableViewCell {
    
    // MARK: - Didset
    var setQuiz: Answer?{
        didSet {
            setupCell()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var quizButton: DLRadioButton!
    
    // MARK: - Let-Var
    var delegate:QuizButtonActionDelegate!
    var indexPath:IndexPath!
    var lastItem = Int()
    
    ///Cleaning
    override func prepareForReuse() {}
    
    func setupCell(){
        guard let quiz = setQuiz else{return}
        quizButton.setTitle(quiz.content, for: .normal)
        
    }
    
    @IBAction func quizActionButton(_ sender: DLRadioButton) {
        
        //quizButton.isSelected = false
        
        self.delegate?.quizAction(at: indexPath)
    }
    
    
    
}
