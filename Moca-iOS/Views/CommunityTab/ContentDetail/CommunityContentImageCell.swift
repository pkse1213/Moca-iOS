//
//  CommunityContentImageCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CommunityContentImageCell: UICollectionViewCell {
    var image: ReviewImage? {
        didSet{ setImage() }
    }
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var gradationImageView: UIImageView!
    
    private func setImage() {
        guard let image = image else { return }
        print("리뷰 이미지")
        contentImageView.imageFromUrl(image.reviewImgURL, defaultImgPath: "")
    }
}
