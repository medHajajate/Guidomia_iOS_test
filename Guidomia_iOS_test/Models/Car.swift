//
//  Car.swift
//  Guidomia_iOS_test
//
//  Created by Hajajate  on 22/12/2022.
//

import Foundation

class Car: Decodable {
    var make: String?
    var model: String?
    var marketPrice: Double?
    var customerPrice: Double?
    var rating: Int?
    var consList: [String?]?
    var prosList: [String?]?
}

extension Car: Hashable {
    static func == (lhs: Car, rhs: Car) -> Bool {
        return lhs.make == rhs.make && lhs.model == rhs.model
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(make)
        hasher.combine(model)
    }
}
