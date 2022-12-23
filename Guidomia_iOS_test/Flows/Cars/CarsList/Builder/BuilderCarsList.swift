//
//  BuilderCarsList.swift
//  Guidomia_iOS_test
//
//  Created by Hajajate  on 22/12/2022.
//

import Foundation
import UIKit

class BuilderCarsList {
    
    func buildCarsList(cars: [Car]) -> [CarInfosViewCell.Data] {
        return cars.map { buildCellData(car: $0)}
    }
    
    private func buildCellData(car: Car) -> CarInfosViewCell.Data {
        CarInfosViewCell.Data(icon: car.make,
                              name: car.model,
                              price: convertPrice(car.marketPrice ?? 0) ,
                              rating: convertRatingsToStars(car.rating ?? 0),
                              isExpandable: false,
                              features: buildFeatures(car: car)
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
    
    
    private func buildFeatures(car: Car) -> [CarProsConsView.Data] {
        var features = [CarProsConsView.Data]()
        if let prosList = car.prosList?.filter({$0 != ""}).compactMap({$0}), prosList.count > 0 {
            features.append(.init(type: "Pros: ",
                                  bulletText: convertFeaturesBulletText(prosList))
            )
        }
        
        if let consList = car.consList?.filter({$0 != ""}).compactMap({$0}), consList.count > 0  {
            features.append(.init(type: "Cons: ",
                                  bulletText: convertFeaturesBulletText(consList))
            )
        }
        return features
    }
    
    private func convertFeaturesBulletText(_ stringList: [String],
             fontText: UIFont = .systemFont(ofSize: 14, weight: .bold),
             bullet: String = "\u{2022}",
             fontBullet: UIFont = .systemFont(ofSize: 26, weight: .bold),
             indentation: CGFloat = 20,
             lineSpacing: CGFloat = 0,
             paragraphSpacing: CGFloat = 0,
             textColor: UIColor = .black,
             bulletColor: UIColor = UIColor.orange) -> NSAttributedString {

        let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: fontText, NSAttributedString.Key.foregroundColor: textColor]
        let bulletAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: fontBullet, NSAttributedString.Key.foregroundColor: bulletColor]

        let paragraphStyle = NSMutableParagraphStyle()
        let nonOptions = [NSTextTab.OptionKey: Any]()
        paragraphStyle.tabStops = [
            NSTextTab(textAlignment: .left, location: indentation, options: nonOptions)]
        paragraphStyle.defaultTabInterval = indentation
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.paragraphSpacing = paragraphSpacing
        paragraphStyle.headIndent = indentation

        let bulletList = NSMutableAttributedString()
        for string in stringList {
            let formattedString = stringList.last == string ? "\(bullet)\t\(string)" : "\(bullet)\t\(string)\n"
            let attributedString = NSMutableAttributedString(string: formattedString)

            attributedString.addAttributes(
                [NSAttributedString.Key.paragraphStyle : paragraphStyle],
                range: NSMakeRange(0, attributedString.length))

            attributedString.addAttributes(
                textAttributes,
                range: NSMakeRange(0, attributedString.length))

            let string:NSString = NSString(string: formattedString)
            let rangeForBullet:NSRange = string.range(of: bullet)
            attributedString.addAttributes(bulletAttributes, range: rangeForBullet)
            bulletList.append(attributedString)
        }

        return bulletList
    }
    
}
