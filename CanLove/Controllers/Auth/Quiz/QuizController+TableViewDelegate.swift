//
//  QuizController+TableViewDelegate.swift
//  CanLove
//
//  Created by Alex on 31/10/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation
import UIKit

extension QuizController: UITableViewDelegate, UITableViewDataSource, QuizButtonActionDelegate{
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedAnswers.count > 0 ? selectedAnswers.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = quizTableView.dequeueReusableCell(withIdentifier: K.cellsIdentifiers.table.quizTableCell, for: indexPath) as? QuizTableCell else { return UITableViewCell() }
        if selectedAnswers.count > 0{
            cell.setQuiz = selectedAnswers[indexPath.row]
            cell.delegate = self
            cell.indexPath = indexPath
            cell.quizButton.tag = indexPath.row
            
            if indexPath == lastSelectedIndexPath{
                cell.quizButton.isSelected = true
                
            }else{
                cell.quizButton.isSelected = false
            }
        }
        return cell
    }
    
    // MARK: - QuizButtonActionDelegate
    func quizAction(at index: IndexPath) {
        
        lastSelectedIndexPath = index

         //let cell = quizTableView.cellForRow(at: index) as? QuizTableCell
        
        quizTableView.reloadData()
        
        
    }
    
    
    

    
    
}
