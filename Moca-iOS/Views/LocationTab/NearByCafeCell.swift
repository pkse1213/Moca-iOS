//
//  NearByCafeCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 8..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class NearByCafeCell: UITableViewCell {
    var cafe: NearByCafe? {
        didSet { setUpData() }
    }
    weak var delegate: ListViewCellDelegate?
    @IBOutlet var cafeImageView: UIImageView!
    @IBOutlet var cafeNameLabel: UILabel!
    @IBOutlet var cafeAddressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    private func setUpData() {
        guard let cafe = cafe else { return }
        cafeNameLabel.text = cafe.cafeName
        cafeAddressLabel.text = cafe.addressDistrictName
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if let vc = UIStoryboard(name: "LocationTab", bundle: nil).instantiateViewController(withIdentifier: "LocationCafeDetailVC") as? LocationCafeDetailVC {
            guard let cafe = cafe else { return }
            vc.cafeId = cafe.cafeID
            delegate?.goToViewController(vc: vc)
            
        }
    }

}
