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

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpCollectionView()
        
        registerGesture()
    }
    
    private func registerGesture() {
        let moreBtnTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(likeDetailAction(_:)))
        self.addGestureRecognizer(moreBtnTapGestureRecognizer)
    }
    
    @objc func likeDetailAction(_:UIImageView) {
        if let vc = UIStoryboard(name: "MyPageTab", bundle: nil).instantiateViewController(withIdentifier: "LikeCafeDetailVC") as? LikeCafeDetailVC {
//            present
        }
    }


    private func setUpCollectionView() {
        cafeImageCollectionView.delegate = self
        cafeImageCollectionView.dataSource = self
    }
}

extension LikeCafeCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cafeImageCollectionView.dequeueReusableCell(withReuseIdentifier: "LikeCafeImageCell", for: indexPath) as! LikeCafeImageCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
