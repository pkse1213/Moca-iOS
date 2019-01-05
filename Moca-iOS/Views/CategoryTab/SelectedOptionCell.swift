//
//  SelectedOptionCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 5..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class SelectedOptionCell: UICollectionViewCell {
    @IBOutlet weak var optionLabel: UILabel!
    var check = true {
        didSet {
            setUpView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyRadius(radius: 5)
    }
    
    private func setUpView() {
        if !check {
            self.applyRadius(radius: 3)
            self.applyBorder(width: 0.7, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        }
    }
}
