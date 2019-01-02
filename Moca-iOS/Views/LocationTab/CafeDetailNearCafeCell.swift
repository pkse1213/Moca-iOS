//
//  CafeDetailNearCafeCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 2..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class CafeDetailNearCafeCell: UITableViewCell {

    @IBOutlet var nearCafeCollectionView: UICollectionView!
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
}

extension CafeDetailNearCafeCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:173*unit , height: 236*unit)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let cafeCell = nearCafeCollectionView.dequeueReusableCell(withReuseIdentifier: "RankingCafeCell", for: indexPath) as? RankingCafeCell {
            cafeCell.rankNumLabel.text = "\(indexPath.row+1)"
            cafeCell.cafeImageView.image = UIImage(named: "sample\(indexPath.row+1)")
            cell = cafeCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
