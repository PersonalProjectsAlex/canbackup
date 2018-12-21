//
//  QuizResponse.swift
//  CanLove
//
//  Created by Alex on 31/10/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation

typealias QuizResponse = [QuizResponseElement]

struct QuizResponseElement: Codable {
    let content, id: String
    let answers: [Answer]
}

struct Answer: Codable {
    let content: String
    let points: Int
    let id: String
}
