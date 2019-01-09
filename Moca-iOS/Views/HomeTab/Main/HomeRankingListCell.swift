//
//  HomeRankingListCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeRankingListCell: UITableViewCell {
    @IBOutlet weak var rankNumLabel: UILabel!
    @IBOutlet weak var cafeImageView: UIImageView!
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var cafeAddressLabel: UILabel!
    @IBOutlet weak var starStackView: UIStackView!
    
    var cafe: RankingCafe? {
        didSet { setUpData() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setUpData() {
        guard let cafe = cafe else { return }
        cafeNameLabel.text = cafe.cafeName
        cafeAddressLabel.text = cafe.addressDistrictName
    }

}
