//
//  CarInfosViewCell.swift
//  Guidomia_iOS_test
//
//  Created by Hajajate  on 22/12/2022.
//

import UIKit

class CarInfosViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var prosConStackView: UIStackView!

    
    // MARK: - ViewLifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Methods
    
    func config(with data: Data) {
        if let icon = data.icon {
            self.iconView.image = UIImage(named: icon)
        }
        self.nameLabel.text = data.name
        self.priceLabel.text = data.price
        self.ratingLabel.text = data.rating
        guard let features = data.features, features.count > 0 else {
            prosConStackView.isHidden = true
            return
        }
        buildProsConsList(features: features)
    }
    
    private func buildProsConsList(features: [CarProsConsView.Data]) {
        prosConStackView.isHidden = false
        prosConStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        features.forEach { feat in
            let view = CarProsConsView.fromNib()
            view.config(with: feat)
            prosConStackView.addArrangedSubview(view)
        }
    }

}


extension CarInfosViewCell {
    
    struct Data {
        let icon: String?
        let name: String?
        let price: String?
        let rating: String?
        var isExpandable: Bool = false
        let features: [CarProsConsView.Data]?
    }
}
