//
//  FacebookUser.swift
//  CanLove
//
//  Created by Alex on 30/10/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation


// TODO: Use one class for facebook users
struct FacebookUser {
    
    let id: Int?
    let name : String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let gender: String?
    let birthday: String?
    
    init (dictionary: [String: Any]) {
        
        self.id = dictionary["id"] as? Int
        self.name = dictionary["name"] as? String
        self.firstName = dictionary["first_name"] as? String
        self.lastName = dictionary["last_name"] as? String
        self.email = dictionary["email"] as? String
        self.gender = dictionary["gender"] as? String
        self.birthday = dictionary["birthday"] as? String
        
    }
    
    init ( id: Int?,name: String?, firstName: String?, lastName: String?, email: String, gender: String?, birthday: String?) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.id = id
        self.name = name
        self.gender = gender
        self.birthday = birthday
        
    }
}
