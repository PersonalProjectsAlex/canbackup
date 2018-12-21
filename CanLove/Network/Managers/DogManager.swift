//
//  DogManager.swift
//  CanLove
//
//  Created by Alex on 5/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation
import Alamofire

class DogManager: APIManager {
    
    
    
    
    /// Getting dogs categories
    ///
    ///
    ///     - completionHandler: Callback to get dogs categories
    
    func dogsBreed(header: HTTPHeaders, completionHandler handler: @escaping (Breed?) -> Void) {
        let questionnairesEndpoint = "\(Endpoints.Dog.DOGSIZES)"
        request(endpoint: questionnairesEndpoint, completionHandler: handler, method: .get, headers: header)
    }
    
    /// Get info about my pets
    ///
    ///
    ///     - completionHandler: Callback to get info about my pets
    func getDogs(header: HTTPHeaders,completionHandler handler: @escaping (MyDogs?) -> Void) {
        let meEndpoint = "\(Endpoints.Dog.DOGSME)"
        request(endpoint: meEndpoint, completionHandler: handler, method: .get, headers: header)
    }
    
    
}
