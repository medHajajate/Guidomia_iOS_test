//
//  CarsListService.swift
//  Guidomia_iOS_test
//
//  Created by Hajajate  on 22/12/2022.
//

import Foundation

protocol CarsListServiceProtocol {
    func fetchCarList(completion: @escaping (Result<[Car], Error>) -> Void)
}

class CarsListService: CarsListServiceProtocol {
    
    var dataParser: JSONFileParser
    
    init(dataParser: JSONFileParser) {
        self.dataParser = dataParser
    }
    
    func fetchCarList(completion: @escaping (Result<[Car], Error>) -> Void) {
        dataParser.parse(of: Car.self, from: "car_list") {  result in
            switch result {
            case .success(let cars):
                completion(.success(cars))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
