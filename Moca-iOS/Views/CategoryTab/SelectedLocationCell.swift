//
//  OptionsLocationCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 5..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class SelectedLocationCell: UICollectionViewCell {
    @IBOutlet var locationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        self.applyRadius(radius: 5)
        self.applyBorder(width: 0.7, color: #colorLiteral(red: 0.9088876247, green: 0.7525063157, blue: 0.6986940503, alpha: 1))
    }
    
}
