//
//  CafeDetailInfoCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 2..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class CafeDetailInfoCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var detailAddressLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    // 기타 정보 관련
    let etcAbleImages = [#imageLiteral(resourceName: "detailviewCar"),#imageLiteral(resourceName: "detailviewWifi"),#imageLiteral(resourceName: "detailviewSmoke"),#imageLiteral(resourceName: "detailview24H"),#imageLiteral(resourceName: "detailviewReservation")]
    let etcEnAbleImages = [#imageLiteral(resourceName: "detailviewCarGray"),#imageLiteral(resourceName: "detailviewWifiGray"),#imageLiteral(resourceName: "detailviewSmokeGray"),#imageLiteral(resourceName: "detailview24HGray"),#imageLiteral(resourceName: "detailviewReservationGray")]
    var etcFlag:[Bool] = [] {
        didSet { setUpEtc() }
    }
    @IBOutlet var etcImageCollection: [UIImageView]!
    @IBOutlet var etcLabelCollection: [UILabel]!
    
    @IBOutlet weak var signatureMenuCollectionView: UICollectionView!
    @IBOutlet weak var reviewLookButton: UIButton!
    
    var signitureMenus = [CafeDetailSigniture]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }
    
    private func setUpEtc() {
        for i in 0...etcFlag.count-1 {
            if etcFlag[i]{
                etcImageCollection[i].image = etcAbleImages[i]
                etcLabelCollection[i].textColor = #colorLiteral(red: 0.9088876247, green: 0.7525063157, blue: 0.6986940503, alpha: 1)
            } else {
                etcImageCollection[i].image = etcEnAbleImages[i]
                etcLabelCollection[i].textColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
            }
        }
    }
    
    private func setUpCollectionView() {
        signatureMenuCollectionView.delegate = self
        signatureMenuCollectionView.dataSource = self
    }
    
    deinit {
        etcImageCollection = nil
    }
}

extension CafeDetailInfoCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return signitureMenus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let menuCell = signatureMenuCollectionView.dequeueReusableCell(withReuseIdentifier: "SignatureMenuCell", for: indexPath) as? SignatureMenuCell {
            let menu = signitureMenus[indexPath.item]
//            menuCell.menuImageView.image =
            menuCell.menuNameLabel.text = menu.cafeSignitureMenu
            menuCell.menuPriceLabel.text = "\(menu.cafeSigniturePrice).0"
            cell = menuCell
        }
        return cell
    }
    
    
}
