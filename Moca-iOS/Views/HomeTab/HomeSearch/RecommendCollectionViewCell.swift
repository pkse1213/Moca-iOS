//
//  RecommendCollectionViewCell.swift
//  Moca-iOS
//
//  Created by 조수민 on 03/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class RecommendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var recommendCafeImage: UIImageView!
    @IBOutlet var recommendCafeLocation: UILabel!
    @IBOutlet var locationView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 이미지 라운드 처리
        recommendCafeImage.layer.masksToBounds = false
        recommendCafeImage.layer.cornerRadius = 5.0
        recommendCafeImage.clipsToBounds = true
        
        // 지역 라운드 처리
        locationView.layer.borderWidth = 0.3
        locationView.layer.borderColor = #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.7490196078, alpha: 1)
        
        locationView.layer.masksToBounds = false
        locationView.layer.cornerRadius = 3.0
        locationView.clipsToBounds = true
    }
    
    
}
