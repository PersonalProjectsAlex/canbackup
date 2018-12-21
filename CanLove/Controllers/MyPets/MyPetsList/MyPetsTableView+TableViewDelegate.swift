//
//  MyPetsTableController+TableViewDelegate.swift
//  CanLove
//
//  Created by Alex on 11/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation
import UIKit

extension MyPetsTableController: UITableViewDataSource, UITableViewDelegate{
    
     // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDogs.count > 0 ? myDogs.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myPetsTableView.dequeueReusableCell(withIdentifier: K.cellsIdentifiers.table.myPetsTableCell, for: indexPath) as? MyPetsTableCell else { return UITableViewCell() }
        if myDogs.count > 0{
            cell.setDog = myDogs[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if myDogs.count > 0{
            selectedDog = myDogs[indexPath.row]
            performSegue(withIdentifier: K.segues.mypets.myPetToMyPetDetailController, sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: K.titles.deleteRowTitle) { (action, indexPath) in
            print("Delete")
            
        }
        
        deleteButton.backgroundColor = #colorLiteral(red: 0.1373712122, green: 0.345433712, blue: 0.4244714379, alpha: 1)

        return [deleteButton]
    }
    
}
