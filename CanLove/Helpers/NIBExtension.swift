//
//  NIBExtension.swift
//  CanLove
//
//  Created by Alex on 19/12/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation
import UIKit

//NibName
extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}


class MyStackView: UIStackView {
    var id : String?
    var idArray = [String]()
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
