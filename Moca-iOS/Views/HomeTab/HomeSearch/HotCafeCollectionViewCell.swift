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
    @IBOutlet var hotcafeNameLabel: UILabel!
    @IBOutlet var hotcafeLikeNumber: UILabel!
    var bestCafe: BestCafe? {
        didSet { setUpData() }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        self.applyRadius(radius: 5)
        self.applyBorder(width: 0.3, color: #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.7490196078, alpha: 1))
    }
    
    private func setUpData() {
        guard let bestCafe = bestCafe else { return }
        hotcafeNameLabel.text = bestCafe.cafeName
        hotcafeLikeNumber.text = "\(bestCafe.scrapCount)"
    }
}
