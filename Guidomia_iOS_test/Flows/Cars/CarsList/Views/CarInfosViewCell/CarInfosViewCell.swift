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
    }

}


extension CarInfosViewCell {
    
    struct Data {
        let icon: String?
        let name: String?
        let price: String?
        let rating: String?
    }
}
