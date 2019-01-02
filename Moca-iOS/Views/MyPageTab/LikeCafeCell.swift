//
//  LikeCafeCell.swift
//  Moca-iOS
//
//  Created by 조수민 on 2018. 12. 29..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class LikeCafeCell: UITableViewCell {
    
    @IBOutlet weak var cafeImageCollectionView: UICollectionView!
    var navigationbarController: UINavigationController?
    
    // 추가
//    var unit: CGFloat = 0.0
    // 추가
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpCollectionView()
    }

    private func setUpCollectionView() {
        cafeImageCollectionView.delegate = self
        cafeImageCollectionView.dataSource = self
    }
    
    // 추가
//    override func viewDidLayoutSubviews() {
//        unit = (self.cafeImageCollectionView.frame.width/5-8)/60
//    }
    // 추가
}

extension LikeCafeCell : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let unit = (self.cafeImageCollectionView.frame.width/5-8)/60


//        let width : CGFloat = (cafeImageCollectionView.frame.width - 32) / 5
//        let height : CGFloat = (cafeImageCollectionView.frame.width - 32) / 5
        
        return CGSize(width: 60 * unit, height: 60 * unit)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cafeImageCollectionView.dequeueReusableCell(withReuseIdentifier: "LikeCafeImageCell", for: indexPath) as! LikeCafeImageCell
        
        if indexPath.row < 4 {
            cell.numberVerticalStack.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.row == 4 {

            if let vc = UIStoryboard(name: "MyPageTab", bundle: nil).instantiateViewController(withIdentifier: "LikeCafeDetailVC") as? LikeCafeDetailVC {
                self.navigationbarController?.pushViewController(vc, animated: true)
            }
        }
    }
}
