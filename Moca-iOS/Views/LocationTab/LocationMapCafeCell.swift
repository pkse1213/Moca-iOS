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
    var selectedFlag = false {
        didSet{
            setBoader()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyRadius(radius: 5)
    }
    
    private func setBoader() {
        if selectedFlag {
            self.applyBorder(width: 3, color: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1))
        } else {
            self.applyBorder(width: 1, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        }
    }
}
