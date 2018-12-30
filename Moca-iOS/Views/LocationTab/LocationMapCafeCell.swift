//
//  LocationMapCafeCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 30..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class LocationMapCafeCell: UICollectionViewCell {
    @IBOutlet var cafeImageView: UIImageView!
    @IBOutlet var cafeNameLabel: UILabel!
    @IBOutlet var cafeLocationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyRadius(radius: 5)
        self.applyBorder(width: 0.5, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    }
}
