//
//  MyDogs.swift
//  CanLove
//
//  Created by Alex on 13/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation

typealias MyDogs = [MyDog]

struct MyDog: Codable {
    let id, name: String
    let yearBirthday, monthBirthday: Int
    let avatar: String
    let lat, long: JSONNull?
    let gender: Bool?
    let weight: Int?
    let canineProfile: CanineProfile?
    let dogBreed: DogBreed?
    let avgReview: Int?
    let dogAge: String?
    let isValidVaccineChart: Bool?
    let lastReviews: [JSONAny]?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case yearBirthday = "year_birthday"
        case monthBirthday = "month_birthday"
        case avatar, lat, long, gender, weight
        case canineProfile = "canine_profile"
        case dogBreed = "dog_breed"
        case avgReview = "avg_review"
        case dogAge = "dog_age"
        case isValidVaccineChart = "is_valid_vaccine_chart"
        case lastReviews = "last_reviews"
    }
}


