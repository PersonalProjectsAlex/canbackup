//
//  WalksManager.swift
//  CanLove
//
//  Created by Alex on 11/12/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation
import Alamofire

class WalksManager: APIManager {
    
    
    /// Getting dogs categories
    ///
    ///
    ///     - completionHandler: Callback to get dogs categories
    
    func requestedWalks(header: HTTPHeaders, params: Parameters, completionHandler handler: @escaping (Breed?) -> Void) {
        let questionnairesEndpoint = "\(Endpoints.Walks.REQUEST_WALKS)"
        request(endpoint: questionnairesEndpoint, completionHandler: handler, method: .get, params: params,headers: header)
    }
    
    
    
}
