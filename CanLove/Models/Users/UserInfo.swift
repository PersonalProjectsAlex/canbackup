//
//  UserInfo.swift
//  CanLove
//
//  Created by Alex on 13/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation

struct UserInfo: Codable {
    let id, fullname, email, customerID: String
    let avatar: String
    let cover: String?
    let avgReview: Int
    let oneSignalToken: String?
    let dogs: [JSONAny]?
    
    enum CodingKeys: String, CodingKey {
        case id, fullname, email
        case customerID = "customer_id"
        case avatar, cover
        case avgReview = "avg_review"
        case oneSignalToken = "one_signal_token"
        case dogs
    }
}
