//
//  Singleton.swift
//  CanLove
//
//  Created by Alex on 30/10/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin

struct Global{
    let defaults = UserDefaults.standard
    let loginManager = LoginManager()
}

class Singleton {
    
    // MARK: - Let-Var
    static let shared = Singleton()
    private init() {}
    
    //------               Callers                     ----/
    
    // MARK: - Single singleton callers
    
    //Setting a way to keep the user logged
    func saveSignInState(){
        Global().defaults.set(K.defaultKeys.auth.signIn, forKey:K.defaultKeys.auth.signIn)
    }
    
    //Setting only avatar
    func updateAvatar(userPhoto: String?){
        
    }
    
    //Saving temporary a date
    func setDate(_ time:String){
        Global().defaults.set(time, forKey:K.defaultKeys.others.dateTemp)
    }
    
    //Saving newPet temporary state
    func setNewPetState(_ isNew:Bool){
        Global().defaults.set(isNew, forKey:K.defaultKeys.others.isNewPet)
    }
    
    // MARK: - Multiple singleton callers
    
    //Setting oauth refresh token
    func setrefreshToken(_ accessToken: String?, _ refreshToken: String?) {
        
    }
    
   
    //Setting info user keys
    func setCurrentUser(_ userName: String?, _ userPhoto: String?, _ userID: String?) {}
    
    //Setting tokens after auth
    
    
    //Setting tokens for hosts
    func setOauthToken(_ accessToken: String?, _ refreshToken: String?){
        Global().defaults.set(accessToken, forKey:K.defaultKeys.auth.accessToken)
        Global().defaults.set(refreshToken, forKey:K.defaultKeys.auth.refreshToken)
    }
    
    
    //------               Functions                     ----/
    
    // MARK: - Multiple functions for Singleton
    
    //Get if isSocial
    func checkisBool(key: String) -> Bool {
        let isSocial = Global().defaults.object(forKey: key) as? Bool
        return isSocial == nil ? false : isSocial!
    }
    
    //Calling a key for a user
    func checkValueSet(key: String) -> String {
        let str = Global().defaults.object(forKey: key) as? String
        return str == nil ? "" : str!
    }
    
    func removeDefault(toRemove: String){
        Global().defaults.removeObject(forKey:toRemove)
    }
    
    //Deleting user settings
    func resetUser(){
        Global().defaults.removeObject(forKey:K.defaultKeys.auth.accessToken)
        Global().defaults.removeObject( forKey:K.defaultKeys.auth.refreshToken)
        Global().defaults.removeObject( forKey:K.defaultKeys.auth.expiresIn)
        Global().defaults.removeObject( forKey:K.defaultKeys.auth.signIn)
        Global().defaults.removeObject( forKey:K.defaultKeys.others.dateTemp)
        Global().defaults.removeObject( forKey:K.defaultKeys.others.isNewPet)
        facebookSignOut()
    }
    
    func facebookSignOut(){
        Global().loginManager.logOut()
    }
    
}
