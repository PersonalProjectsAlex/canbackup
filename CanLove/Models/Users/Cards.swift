//
//  Cards.swift
//  CanLove
//
//  Created by Alex on 14/12/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation

typealias Cards = [Card]

struct Card: Codable {
    let id, stripeSource: String
    let isDefault: Bool
    let friendlyCard: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case stripeSource = "stripe_source"
        case isDefault = "is_default"
        case friendlyCard = "friendly_card"
    }
}

//--Delete cards
struct RemovedCards: Codable {
    let id, userID, stripeSource, createdAt: String
    let updatedAt: String
    let isDefault: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case stripeSource = "stripe_source"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isDefault = "is_default"
    }
}

