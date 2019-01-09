//
//  CafeDetailNearCafeCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 2..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class CafeDetailNearCafeCell: UITableViewCell {
    var nearByCafes: [NearByCafe]?
    weak var delegate: ListViewCellDelegate?
    
    @IBOutlet var nearCafeCollectionView: UICollectionView!
    @IBOutlet var moreLookButton: UIButton!
    var unit: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        unit = (nearCafeCollectionView.frame.width/2-3)/173
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        nearCafeCollectionView.delegate = self
        nearCafeCollectionView.dataSource = self
    }
    
    @IBAction func moreLookAction(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "LocationTab", bundle: nil).instantiateViewController(withIdentifier: "NearByCafeListVC") as? NearByCafeListVC {
            vc.nearByCafes = nearByCafes
            delegate?.goToViewController(vc: vc)
        }
    }
}

extension CafeDetailNearCafeCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:173*unit , height: 236*unit)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cafes = nearByCafes else { return 0 }
        if cafes.count < 5 {
            moreLookButton.isHidden = true
            return cafes.count
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        guard let cafes = nearByCafes else { return cell }
        
        if let cafeCell = nearCafeCollectionView.dequeueReusableCell(withReuseIdentifier: "RankingCafeCell", for: indexPath) as? RankingCafeCell {
            let cafe = cafes[indexPath.item]
            cafeCell.cafeNameLabel.text = cafe.cafeName
            cafeCell.cafeAddressLabel.text = cafe.addressDistrictName
            cafeCell.cafeImageView.image = UIImage(named: "sample\(indexPath.row+1)")
            cell = cafeCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "LocationTab", bundle: nil).instantiateViewController(withIdentifier: "LocationCafeDetailVC") as? LocationCafeDetailVC {
            guard let cafe = nearByCafes?[indexPath.item] else { return }
            vc.cafeId = cafe.cafeID
            delegate?.goToViewController(vc: vc)
        }
    }
}
