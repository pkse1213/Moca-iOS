//
//  CagegoryMenuCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 5..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class CategoryMenuCell: UICollectionViewCell {
    @IBOutlet var menuImageView: UIImageView!
    var selectedFlag = false {
        didSet {
            changeImage()
        }
    }
    var defalutImage = UIImage()
    var selectedImage = UIImage()
    
    
    func changeImage() {
        if selectedFlag {
            menuImageView.image = selectedImage
        } else {
            menuImageView.image = defalutImage
        }
    }
    
}
