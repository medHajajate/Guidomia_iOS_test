//
//  CarFilterHeaderView.swift
//  Guidomia_iOS_test
//
//  Created by Hajajate  on 24/12/2022.
//

import UIKit

class CarFilterHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Outlets
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
