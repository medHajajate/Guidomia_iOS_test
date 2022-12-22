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
