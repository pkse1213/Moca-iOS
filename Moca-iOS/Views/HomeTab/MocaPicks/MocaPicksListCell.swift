//
//  MocaPicksListCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPicksListCell: UITableViewCell {

    @IBOutlet weak var cafeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var mocaPicks: MocaPicks? {
        didSet { setUpData() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUpData() {
        guard let mocaPicks = mocaPicks else { return }
        nameLabel.text = mocaPicks.cafeName
        addressLabel.text = mocaPicks.addressDistrictName
    }

}
