//
//  JSONFileParser.swift
//  Guidomia_iOS_test
//
//  Created by Hajajate  on 22/12/2022.
//

import Foundation

class JSONFileParser {
    
    enum DataError: Error {
        case invalidData
        case decodingError
        case fileNotFound
    }
    
    func parse<T: Decodable>(of type: T.Type,
                             from fileName: String,
                             completion: @escaping (Result<[T], Error>) -> Void) {
        do {
            if let bundlePath = Bundle.main.path(forResource: fileName, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                do {
                    let decodedData: [T] = try JSONDecoder().decode([T].self, from: jsonData)
                    completion(.success(decodedData))
                }
                catch {
                    completion(.failure(DataError.decodingError))
                }
            } else {
                throw DataError.invalidData
            }
        } catch {
            completion(.failure(DataError.fileNotFound))
        }
    }
}
