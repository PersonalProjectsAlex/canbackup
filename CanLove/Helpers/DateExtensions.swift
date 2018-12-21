//
//  DateExtensions.swift
//  CanLove
//
//  Created by Alex on 5/12/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation

//Date to millis
extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}



//extension Array where Element: Equatable {
//    mutating func removeDuplicates() {
//        var result = [Element]()
//        for value in self {
//            if !result.contains(value) {
//                result.append(value)
//            }
//        }
//        self = result
//    }
//}
