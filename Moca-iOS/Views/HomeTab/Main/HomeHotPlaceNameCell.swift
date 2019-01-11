//
//  ConceptListCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 25..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeHotPlaceNameCell: UICollectionViewCell {
    
    @IBOutlet weak var hotPlaceImageView: UIImageView!
    @IBOutlet weak var hotPlaceNameLabel: UILabel!
    var hotPlaceName: HotPlaceName? {
        didSet { setUpData() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        hotPlaceImageView.applyRadius(radius: 40)
    }
    
    private func setUpData() {
        guard let hotPlaceName = hotPlaceName else { return }
        hotPlaceNameLabel.text = hotPlaceName.hotPlaceName
        hotPlaceImageView.imageFromUrl(hotPlaceName.hotPlaceImg, defaultImgPath: "")
    }
}
