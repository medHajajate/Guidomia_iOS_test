//
//  CarsListServiceTest.swift
//  Guidomia_iOS_testTests
//
//  Created by Hajajate  on 25/12/2022.
//

import XCTest
@testable import Guidomia_iOS_test

class CarsListServiceTest: XCTestCase {

    
    func makeServiceSUT() -> CarsListService {
        let sut = CarsListService(dataParser: JSONFileParser())
        return sut
    }
    
}
