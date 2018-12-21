//
//  MyProfileInfoController+TableViewDelegate.swift
//  CanLove
//
//  Created by Alex on 12/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation
import UIKit

extension MyProfileInfoController: UITableViewDelegate,UITableViewDataSource{
     // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = commentsTableView.dequeueReusableCell(withIdentifier: K.cellsIdentifiers.table.userCommentsTableCell, for: indexPath) as? UserCommentsTableCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
