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
            self.applyBorder(width: 1.5, color: #colorLiteral(red: 0.9088876247, green: 0.7525063157, blue: 0.6986940503, alpha: 1))
        } else {
            self.applyBorder(width: 0.5, color: #colorLiteral(red: 0.8769704103, green: 0.8771176934, blue: 0.8769509196, alpha: 1))
        }
    }
}
