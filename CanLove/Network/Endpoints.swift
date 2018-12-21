//
//  Endpoints.swift
//  Tugo
//
//  Created by Alex on 16/8/18.
//  Copyright © 2018 Tugo. All rights reserved.
//

import Foundation

struct Endpoints {
    
    static let BASE_URL_ENV = "https://canlove-v2-api-stg.herokuapp.com/"
    
    
    //Base path for user's endpoint
    static let BASE_USER = "\(BASE_URL_ENV)user/v1/"
    static let Geocode = "https://maps.googleapis.com/maps/api/geocode/json"
    
    struct Users {
        
        //--User
        static let OAUTH = "\(BASE_USER)oauth/token"
        static let SIGNUP = "\(BASE_USER)resources/sign-up"
        static let USERME = "\(BASE_USER)users/me"
        static let CHANGEPASSWORD = "\(BASE_USER)users/change_password"
         static let ADDPET = "\(BASE_USER)users/dogs"
        
        //--Payments
        static let CARDS = "\(BASE_USER)users/cards"
        
        
    }
    
    
    
    struct Dog {
        static let DOGSIZES = "\(BASE_USER)commons/dog_sizes"
        static let DOGSME = "\(BASE_USER)users/dogs"
    }
    
    struct Questionnaires {
        static let QUESTIONS  = "\(BASE_USER)questionnaires/"
        
    }
    
    struct Experiences {
        //Experiences
        static let EXPERIENCES = "\(BASE_USER)experiences"
        static let EXPERIENCESFILTER = "\(BASE_USER)experiences/filter"
        static let COUNT = "\(BASE_USER)experiences/count"
        static let SEARCH = "\(BASE_USER)experiences/search"
    }
    
    struct Categories {
        //Categories
        static let SETCATEGORIES = "\(BASE_USER)categories"
        static let CATEGORIES = "\(BASE_USER)categories/last_experience"
        static let CATEGORIESME = "\(BASE_USER)categories/my_categories"
    }
    
    
    struct Walks {
        static let REQUEST_WALKS = "\(BASE_USER)request_walks"
    }
    
    struct Books{
        static let BookingTest = "\(BASE_USER)reservations/reservations_test"
        static let Booking = "\(BASE_USER)reservations"
    }
    
   
    
}
