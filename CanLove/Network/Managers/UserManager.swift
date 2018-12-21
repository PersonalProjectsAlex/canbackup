//
//  UserManager.swift
//  CanLove
//
//  Created by Alex on 29/10/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation
import Alamofire


class UserManager: APIManager {
    
    
    /// Oauth for users.
    ///
    ///
    ///     - completionHandler: Callback with Oauth/Token value
    
    func getOauthToken(params: Parameters,completionHandler handler: @escaping (Oauth?) -> Void) {
        let oauthEndpoint = "\(Endpoints.Users.OAUTH)"
        
        request(endpoint: oauthEndpoint, completionHandler: handler, method: .post, params: params)
    }
    
    /// Sign Up for users.
    ///
    ///
    ///     - completionHandler: Callback to sign up users
    
    func registerUser(params: Params,completionHandler handler: @escaping (Oauth?) -> Void) {
        let userEndpoint = "\(Endpoints.Users.SIGNUP)"
        request(endpoint: userEndpoint, completionHandler: handler, method: .post, params: params)
    }
    
    /// Get info about an user
    ///
    ///
    ///     - completionHandler: Callback to get info about an user
    func getUserInfo(header: HTTPHeaders,completionHandler handler: @escaping (UserInfo?) -> Void) {
        let meEndpoint = "\(Endpoints.Users.USERME)"
        request(endpoint: meEndpoint, completionHandler: handler, method: .get, headers: header)
    }

    
    /// Getting questions for a Quiz
    ///
    ///
    ///     - completionHandler: Callback to get questions for a quiz
    
    func questionsQuiz(abb: String,header: HTTPHeaders, completionHandler handler: @escaping (QuizResponse?) -> Void) {
        let questionnairesEndpoint = "\(Endpoints.Questionnaires.QUESTIONS)\(abb)/questions"
        request(endpoint: questionnairesEndpoint, completionHandler: handler, method: .get, headers: header)
    }
    
    /// Register a pet
    ///
    ///
    ///     - completionHandler: Callback for registering a pet
    
    func registerPet(params: Params, header: HTTPHeaders,completionHandler handler: @escaping (NewPet?) -> Void) {
        let userEndpoint = "\(Endpoints.Users.ADDPET)"
        request(endpoint: userEndpoint, completionHandler: handler, method: .post, params: params, headers: header)
    }

    
    /*Actions for Cards*/
    
    /// Get cards for an user
    ///
    ///
    ///     - completionHandler: Callback to get user's card
    
    func getCards(header: HTTPHeaders,completionHandler handler: @escaping (Cards?) -> Void) {
        let userEndpoint = "\(Endpoints.Users.CARDS)"
        
        request(endpoint: userEndpoint, completionHandler: handler, method: .get, headers: header)
    }
    
    /// Register a new card for an user.
    ///
    ///
    ///     - completionHandler: Callback to register a car
    
    func registerNewCard(header: HTTPHeaders,params: Parameters,completionHandler handler: @escaping (Card?) -> Void) {
        let userEndpoint = "\(Endpoints.Users.CARDS)"
        request(endpoint: userEndpoint, completionHandler: handler, method: .post, params: params, headers:header)
    }
    
    /// Delete a new card for an user.
    ///
    ///
    ///     - completionHandler: Callback to delete a car
    
    func deleteCard(header: HTTPHeaders,cardID: String,completionHandler handler: @escaping (RemovedCards?) -> Void) {
        let userEndpoint = "\(Endpoints.Users.CARDS)\("/"+cardID)"
        print(userEndpoint)
        
        request(endpoint: userEndpoint, completionHandler: handler, method: .delete, headers:header)
    }

}

