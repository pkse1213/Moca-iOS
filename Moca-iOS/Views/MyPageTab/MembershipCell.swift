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
    
    var parentVC = UIViewController()
    
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
    
    
    @IBAction func goToMembershipHistoryAction(_ sender: Any) {
        if let vc = UIStoryboard(name: "MyPageTab", bundle: nil).instantiateViewController(withIdentifier: "SavingHistoryVC") as? SavingHistoryVC {
            parentVC.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension MembershipCell :  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//
//
////        let width : CGFloat = (couponCollectionView.frame.width - 90) / 4
////        let height : CGFloat = (couponCollectionView.frame.width - 90) / 4
////
////        return CGSize(width: width, height: height)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = couponCollectionView.dequeueReusableCell(withReuseIdentifier: "MembershipCouponCollectionCell", for: indexPath) as! MembershipCouponCollectionCell
        
        return cell
    }
}
