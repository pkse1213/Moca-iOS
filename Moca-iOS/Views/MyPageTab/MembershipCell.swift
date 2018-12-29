//
//  MembershipCell.swift
//  Moca-iOS
//
//  Created by 조수민 on 2018. 12. 29..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MembershipCell: UITableViewCell {
    
    @IBOutlet weak var couponCollectionView: UICollectionView!
    
    let margin: CGFloat = 10
    let cellsPerRow = 4
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setUpCollectionView()
        
//        guard let flowLayout = couponCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout else { return }
//        flowLayout.minimumInteritemSpacing = margin
//        flowLayout.minimumLineSpacing = margin
//        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
//        flowLayout.estimatedItemSize = flowLayout.itemSize // CGSize(width: 50, height: 50)
    }
    
    private func setUpCollectionView() {
        couponCollectionView.delegate = self
        couponCollectionView.dataSource = self
    }
    
    

}

extension MembershipCell :  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat = (couponCollectionView.frame.width) / 3
        let height : CGFloat = (couponCollectionView.frame.width ) / 3
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = couponCollectionView.dequeueReusableCell(withReuseIdentifier: "MembershipCouponCollectionCell", for: indexPath) as! MembershipCouponCollectionCell
        
        return cell
    }
}
