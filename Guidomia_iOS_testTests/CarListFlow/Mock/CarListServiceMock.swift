//
//  CarListServiceMock.swift
//  Guidomia_iOS_testTests
//
//  Created by Hajajate  on 25/12/2022.
//

import Foundation
@testable import Guidomia_iOS_test

class CarListServiceMock: CarsListServiceProtocol {
    
    var fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func fetchCarList(completion: @escaping (Result<[Car], Error>) -> Void) {
        JSONFileParser().parse(of: Car.self, from: fileName) {  result in
            switch result {
            case .success(let cars):
                completion(.success(cars))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
