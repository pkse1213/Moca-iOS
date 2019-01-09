//
//  MocaPicksCafeListCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 25..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeMocaPicksCafeListCell: UICollectionViewCell {
    var cafe: MocaPicks? {
        didSet { setUpData() }
    }
    @IBOutlet weak var cafeImageView: UIImageView!
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var cafeAddressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        self.cafeImageView.applyShadow(radius: 5, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), offset: CGSize(width: 3, height: 3), opacity: 0.2)
    }
    
    private func setUpData() {
        guard let cafe = cafe else { return }
        cafeNameLabel.text = cafe.cafeName
        cafeAddressLabel.text = cafe.addressDistrictName
    }
}
