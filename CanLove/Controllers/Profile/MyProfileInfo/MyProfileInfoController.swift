//
//  MyProfileInfoController.swift
//  CanLove
//
//  Created by Alex on 12/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import Cosmos

class MyProfileInfoController: UIViewController{
    
    // MARK: - Let-Var
    //--Header
    open var header: HTTPHeaders{
        let token = Singleton.shared.checkValueSet(key: K.defaultKeys.auth.accessToken)
        let bearer = Core.shared.setBearerToken(token)
        return ["Authorization": bearer]
    }
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var starRaitingView: CosmosView!
    
    
    @IBOutlet weak var commentsTableView: UITableView!
    
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // setting up general actions/delegates/Core
        setUpActions()
        
        // setting up UI elements to be used through the code
        setUpUI()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        gettingData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
 
    func setUpUI(){
        
    }
    
    func setUpActions(){
        //Tableview Delegate
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        
        //Set Cell Identifier
        Core.shared.registerCell(at: commentsTableView, named: K.cellsIdentifiers.table.userCommentsTableCell)
    }
    
    private func gettingData(){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        UserManager().getUserInfo(header: header) {
            userinfo in
            guard let userInfo = userinfo else{return}
            weak.nameLabel.text = userInfo.fullname
            
            weak.profileImageView.sd_setImage(with: URL(string: userInfo.avatar), placeholderImage: #imageLiteral(resourceName: "perro"))
            if let starsFormatted = Double(exactly: userInfo.avgReview){
                weak.starRaitingView.rating = starsFormatted
            }
            
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
