//
//  MembershipCouponCollectionCell.swift
//  Moca-iOS
//
//  Created by 조수민 on 2018. 12. 29..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MembershipCouponCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var couponImageView: UIImageView!
    var cellUnit : CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("cellUnit = \(cellUnit)")
        
//        var radius = couponImageView.frame.width * unit
//        print(radius)
        
        couponImageView.layer.masksToBounds = false
        couponImageView.layer.cornerRadius = couponImageView.frame.width / 2
        couponImageView.clipsToBounds = true
        
//        print(couponImageView.frame.width)
    }
    
}
