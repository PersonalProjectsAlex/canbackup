//
//  ResponseFIrebaseDataBase.swift
//  CanLove
//
//  Created by Alex on 6/12/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation

//struct Points: Codable {
//    //let q: String
//
//    let v: [String: V]?
//
//    private struct CustomCodingKeys: CodingKey {
//        var stringValue: String
//        init?(stringValue: String) {
//            self.stringValue = stringValue
//        }
//        var intValue: Int?
//        init?(intValue: Int) {
//            return nil
//        }
//    }
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CustomCodingKeys.self)
//
//        self.v = [String: V]()
//        for key in container.allKeys {
//            let value = try container.decode(v.self, forKey: CustomCodingKeys(stringValue: key.stringValue)!)
//            self.empty[key.stringValue] = value
//        }
//    }
//}
//
//struct V: Codable {
//    let latitude, longitude: Double
//}


typealias Points = [String: [String: TimeValue]]

struct TimeValue: Codable {
    let latitude, longitude: Double
}



// struct Points: Codable {
//    public var empty: [String: Inner]
//
//
//    struct Inner: Codable {
//        let latitude, longitude: Double
//    }
//
//    private struct CustomCodingKeys: CodingKey {
//        var stringValue: String
//        init?(stringValue: String) {
//            self.stringValue = stringValue
//        }
//        var intValue: Int?
//        init?(intValue: Int) {
//            return nil
//        }
//    }
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CustomCodingKeys.self)
//
//        self.empty = [String: Inner]()
//        for key in container.allKeys {
//            let value = try container.decode(Inner.self, forKey: CustomCodingKeys(stringValue: key.stringValue)!)
//            self.empty[key.stringValue] = value
//        }
//    }
//}
