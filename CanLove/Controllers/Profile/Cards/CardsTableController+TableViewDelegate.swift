//
//  CardsTableController+TableViewDelegate.swift
//  CanLove
//
//  Created by Alex on 12/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation
import UIKit

extension CardsTableController: UITableViewDelegate, UITableViewDataSource{
     // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count > 0 ? cards.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cardsTableView.dequeueReusableCell(withIdentifier: K.cellsIdentifiers.table.cardsTableCell, for: indexPath) as? CardsTableCell else { return UITableViewCell() }
        if cards.count > 0{
            cell.setCards = cards[indexPath.row]
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteButton = UITableViewRowAction(style: .default, title: K.titles.deleteRowTitle) { (action, indexPath) in
            
            weak var weakSelf = self
            guard let weak = weakSelf else{return}
            
            guard case let cards =  weak.cards.count > 0 else{return}
            
            let cardID = weak.cards[indexPath.row].id
            
            UserManager().deleteCard(header: weak.header, cardID: cardID, completionHandler: { card  in
                guard let card = card else{return}
                
                weak.gettingData()
            })
            
        }
        
        deleteButton.backgroundColor = #colorLiteral(red: 0.1373712122, green: 0.345433712, blue: 0.4244714379, alpha: 1)
        
        return [deleteButton]
    }
    
    
}
