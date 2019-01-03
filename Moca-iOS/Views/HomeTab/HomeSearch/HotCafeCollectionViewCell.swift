//
//  HotCafeCollectionViewCell.swift
//  Moca-iOS
//
//  Created by 조수민 on 03/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class HotCafeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var hotcafeImageView: UIImageView!
    @IBOutlet var hotcafeName: UILabel!
    @IBOutlet var hotcafeLikeNumber: UILabel!
    
    @IBOutlet var textView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textView.layer.borderWidth = 0.3
        textView.layer.borderColor = #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.7490196078, alpha: 1)
        
        textView.layer.masksToBounds = false
        textView.layer.cornerRadius = 5.0
        textView.clipsToBounds = true
    }
}
