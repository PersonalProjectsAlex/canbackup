//
//  Breeds.swift
//  CanLove
//
//  Created by Alex on 5/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation

typealias Breed = [BreedElement]

struct BreedElement: Codable {
    let id, size: String
    let listBreeds: [ListBreed]
    
    enum CodingKeys: String, CodingKey {
        case id, size
        case listBreeds = "list_breeds"
    }
}

struct ListBreed: Codable {
    let id, name: String
    let cover: String
}
