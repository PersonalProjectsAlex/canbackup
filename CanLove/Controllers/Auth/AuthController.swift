//
//  AuthController.swift
//  CanLove
//
//  Created by Alex on 30/10/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FacebookCore
import FacebookLogin
import Firebase
import Alamofire
import TransitionButton
import NVActivityIndicatorView


class AuthController: UIViewController, NVActivityIndicatorViewable{

    // MARK: - Let-Var
    //--Facebook
        var facebookUser: FacebookUser?
        let loginManager = LoginManager()
        let readPermissions: [ReadPermission] = [ .publicProfile, .email]
    
    var buttonIsTapped = false
    
    // MARK: - Outlets
    @IBOutlet weak var transitionButton: TransitionButton!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Checking if facebook token is empty or the auth has been cancelled by user
        if FBSDKAccessToken.current() != nil && buttonIsTapped{
            transitionButton.stopAnimation()
            stopAnimating()
        }
        
        
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
    
    // MARK: - SetUps / Funcs
    
    func setUpUI(){}
    
    func setUpActions(){}
    
    private func gettingData(){}
    
    @IBAction func authAction(_ sender: UIButton) {
        
        transitionButton.startAnimation()
        buttonIsTapped = true
        customLoading()
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        loginManager.logIn(readPermissions: readPermissions, viewController: self) {
            loginResult in
            
            guard case .success = loginResult else {
                weak.transitionButton.stopAnimation()
                weak.stopAnimating()
                return }
            
            
            guard let accessToken = AccessToken.current else { return }
            let facebookAPIManager = FacebookAPIManager(accessToken: accessToken)
            
            facebookAPIManager.requestFacebookUser {
                facebookUser in
                
                weak.facebookUser = facebookUser
                if let userID = accessToken.userId{
                    
                    //--User data
                    guard let facebookFirstName = facebookUser.firstName, let facebookLastName = facebookUser.lastName  else{return}
                    guard let email = facebookUser.email else{return}
                    let avatar = "http://graph.facebook.com/\(userID)/picture?type=large"
                    let fullName = "\(facebookFirstName) \(facebookLastName)"
                    
                    //Getting credential in order to use with firebase
                    let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
                    
                    //Let's authenticate an user
                    weak.buttonIsTapped = false
                    weak.signUp(email: email, userName: facebookFirstName, fullName: fullName, avatar: avatar, accountID: userID)
                    
//                    if let userFIrebase = Core.shared.firebaseAuth(Credential: credential){
//                        print(userFIrebase)
//
//                    }
                    
                   
                }
            }
        }
    }
    
    
    /// 📱 The user will be authenticated in order to be headed on app.
    /**
     - Parameters:
     - email: Email from facebook
     - userName: While is defined here you set the firstname from facebook
     - fullName: Fullname (First+Last name from facebook)
     - avatar: Photo as profile on facebook
     - accountID: Facebook ID as user
     
     - Returns: If everything though our auth is ok, the user will be redirected to create a profile for a dog
     */
    func signUp(email: String, userName: String, fullName:String, avatar:String, accountID:String){
      
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        let params:Parameters = ["email": email, "username": userName, "fullname": fullName, "avatar": avatar, "provider": "123", "account_id":accountID]
        
        //Authenticating user
        UserManager().registerUser(params: params) {
            oauth in
            guard let oauth = oauth else{ weak.stopAnimating()
                return}
            let accessToken = oauth.accessToken
            let refreshToken = oauth.accessToken
            
            //Stop button animation and loading
            weak.transitionButton.stopAnimation()
            weak.stopAnimating()
            print(accessToken)
            //Setting response on SIngleton to go ahead using token
            Singleton.shared.setOauthToken(accessToken, refreshToken)
            Singleton.shared.saveSignInState()
            
            //Passing next controller
            weak.performSegue(withIdentifier: K.segues.auth.signupToDogProfileController, sender: weak)
        }
    }
    
    //Custom loading
    func customLoading(){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        let size = CGSize(width: 32, height: 32)
        weak.startAnimating(size, message: "", type: NVActivityIndicatorType.circleStrokeSpin)
    }
    

}
