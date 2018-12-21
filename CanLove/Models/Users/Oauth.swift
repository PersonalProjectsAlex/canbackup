//
//  Oauth.swift
//  CanLove
//
//  Created by Alex on 30/10/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation

struct Oauth: Codable {
    let accessToken, refreshToken: String
    let expiresIn: Int
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
    }
}
