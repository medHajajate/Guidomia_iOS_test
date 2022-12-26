//
//  BuilderCarsListTest.swift
//  Guidomia_iOS_testTests
//
//  Created by Hajajate  on 25/12/2022.
//

import XCTest
@testable import Guidomia_iOS_test


class BuilderCarsListTest: XCTestCase {

    func makeCarsListData() -> [Car] {
           
           let carFisrt = Car()
           carFisrt.make = "Land Rover"
           carFisrt.model = "Range Rover"
           carFisrt.marketPrice = 120000.0
           carFisrt.customerPrice = 125000.0
           carFisrt.rating = 3
           carFisrt.consList = ["Bad direction"]
           carFisrt.prosList = ["You can go everywhere", "Good sound system"]

           let carSecond = Car()
           carSecond.make = "BMW"
           carSecond.model = "3300i"
           carSecond.marketPrice = 65000.0
           carSecond.customerPrice = 55900.0
           carSecond.rating = 5
           carSecond.consList = ["You can heard the engine over children cry at the back", "You may lose this one if you divorce"]
           carSecond.prosList = ["Your average business man car", "Can bring the family home safely"]
           
           return [carFisrt, carSecond]
       }
    
    func testBuildCarListData() {
        let cars = makeCarsListData()
        let builder = BuilderCarsList()
        let viewDataList = builder.buildCarsList(cars: cars)
        XCTAssertEqual(cars.count, viewDataList.count)
        XCTAssertEqual(cars.first?.model, viewDataList.first?.name)
    }
}
