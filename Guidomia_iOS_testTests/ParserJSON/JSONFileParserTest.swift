//
//  JSONFileParserTest.swift
//  Guidomia_iOS_testTests
//
//  Created by Hajajate  on 26/12/2022.
//

import UIKit
import XCTest
@testable import Guidomia_iOS_test

class JSONFileParserTest: XCTestCase {

    func makeSUT() -> JSONFileParser {
        return JSONFileParser()
    }
    
    func testSucceedPasring() {
        let parser = makeSUT()
        var carList = [Car]()
        parser.parse(of: Car.self, from: "test_car_list") { result in
            if case .success(let cars) = result {
                carList = cars
            }
        }
        XCTAssertFalse(carList.isEmpty)
    }
    
    func testFailurePasringwithDecodingError() {
        let parser = makeSUT()
        var carList = [Car]()
        var errorResult: Error? = nil
        
        parser.parse(of: Car.self, from: "invalid_test_car_list") { result in
            if case .failure(let error) = result {
                carList = []
                errorResult = error
            }
        }
        XCTAssertTrue(carList.isEmpty)
        XCTAssertTrue(errorResult is JSONFileParser.DataError)
        XCTAssertEqual(errorResult?.localizedDescription, JSONFileParser.DataError.decodingError.localizedDescription)
    }
    
    func testFailurePasringwithFileNotFound() {
        let parser = makeSUT()
        var carList = [Car]()
        var errorResult: Error? = nil
        
        parser.parse(of: Car.self, from: "test") { result in
            if case .failure(let error) = result {
                carList = []
                errorResult = error
            }
        }
        XCTAssertTrue(carList.isEmpty)
        XCTAssertTrue(errorResult is JSONFileParser.DataError)
        XCTAssertEqual(errorResult?.localizedDescription, JSONFileParser.DataError.fileNotFound.localizedDescription)
    }
}
