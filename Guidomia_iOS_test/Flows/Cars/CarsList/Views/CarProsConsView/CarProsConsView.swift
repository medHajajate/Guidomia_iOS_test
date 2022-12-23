//
//  CarProsConsView.swift
//  Guidomia_iOS_test
//
//  Created by Hajajate  on 23/12/2022.
//

import UIKit

class CarProsConsView: UIView {

    // MARK: - Outlets
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var bulletLabel: UILabel!
    
    // MARK: - Initializers

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //fromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //fromNib()
    }
    
    // MARK: - Methods
    
    func config(with data: Data) {
        typeLabel.text = data.type
        bulletLabel.attributedText = data.bulletText
    }
}

extension CarProsConsView {
    
    struct Data {
        let type: String?
        let bulletText: NSAttributedString?
    }
}
