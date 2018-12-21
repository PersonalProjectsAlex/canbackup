//
//  SetNewWalkThroughController+TableViewDelegate.swift
//  CanLove
//
//  Created by Alex on 10/12/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation
import UIKit

extension SetNewWalkThroughController: UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = walksTableView.dequeueReusableCell(withIdentifier: K.cellsIdentifiers.table.scheduledWalk, for: indexPath) as? SheduledWalkTableCell else { return UITableViewCell() }
        cell.isGoing = true
        return cell
    }
    
    
    
}
