//
//  BuilderCarsList.swift
//  Guidomia_iOS_test
//
//  Created by Hajajate  on 22/12/2022.
//

import Foundation

class BuilderCarsList {
    
    func buildCarsList(cars: [Car]) -> [CarInfosViewCell.Data] {
        return cars.map { buildCellData(car: $0)}
    }
    
    private func buildCellData(car: Car) -> CarInfosViewCell.Data {
        CarInfosViewCell.Data(icon: car.make,
                              name: car.model,
                              price: convertPrice(car.marketPrice ?? 0) ,
                              rating: convertRatingsToStars(car.rating ?? 0)
        )
    }
    
    private func convertPrice(_ price: Double) -> String {
        let price = Int(price / 1000)
        return "Price : \(price)k"
    }
    
    private func convertRatingsToStars(_ rating: Int) -> String {
        
        switch rating {
        case 1:
            return "⭐"
        case 2:
            return "⭐ ⭐"
        case 3:
            return "⭐ ⭐ ⭐"
        case 4:
            return "⭐ ⭐ ⭐ ⭐"
        case 5:
            return "⭐ ⭐ ⭐ ⭐ ⭐"
        default:
            return ""
        }
        
    }
    
}
