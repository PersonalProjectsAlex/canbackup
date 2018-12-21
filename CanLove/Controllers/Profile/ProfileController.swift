//
//  ProfileController.swift
//  CanLove
//
//  Created by Alex on 13/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ProfileController: UITableViewController {
    
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    
    // MARK: - SetUps / Funcs
    func setUpUI(){}
    
    func setUpActions(){}
    
    private func gettingData(){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        UserManager().getUserInfo(header: header) {
            userinfo in
            guard let userInfo = userinfo else{return}
            weak.nameLabel.text = userInfo.fullname
            weak.profileImageView.sd_setImage(with: URL(string: userInfo.avatar), placeholderImage: #imageLiteral(resourceName: "perro"))
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 6:
            //Sign out at Singleton
            Singleton.shared.resetUser()
            //Going back to auth
            performSegue(withIdentifier: K.segues.profile.profileToAuthController, sender: nil)
        default:
            print("")
        }
    }
    
    // MARK: - Objective C

}
