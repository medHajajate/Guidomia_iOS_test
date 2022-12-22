//
//  NSObject+Extension.swift
//  Guidomia_iOS_test
//
//  Created by Hajajate  on 22/12/2022.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
