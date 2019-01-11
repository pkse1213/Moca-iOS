//
//  ConceptTableViewCell.swift
//  Moca-iOS
//
//  Created by 조수민 on 06/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class HotPlaceCafeCell: UITableViewCell {
    @IBOutlet var cafeNameLabel: UILabel!
    @IBOutlet var cafeAddressLabel: UILabel!
    @IBOutlet var conceptStar1: UIImageView!
    @IBOutlet var conceptStar2: UIImageView!
    @IBOutlet var conceptStar3: UIImageView!
    @IBOutlet var conceptStar4: UIImageView!
    @IBOutlet var conceptStar5: UIImageView!
    @IBOutlet var imageCollectionView: UICollectionView!
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    var cafe: HotPlaceCafe? {
        didSet {
            setUpData()
            initImageData()
        }
    }
    var images: [CafeDetailImage]? {
        didSet { imageCollectionView.reloadData() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func initImageData() {
        guard let cafe = cafe else { return }
        CafeDetailImageService.shareInstance.getCafeDetailImage(cafeId: cafe.cafeID, token: token, completion: { (res) in
            self.images = res
        }) { (err) in
            self.images = []
            print("핫플레이스 카페 이미지 실패 \(err)")
        }
    }
    
    private func setUpData() {
        guard let cafe = cafe else { return }
        cafeNameLabel.text = cafe.cafeName
        cafeAddressLabel.text = cafe.cafeSubway
    }
    
    private func setUpCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }
    
}

extension HotPlaceCafeCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let images = images else { return 0 }
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let imgCell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "HotPlaceCafeImageCell", for: indexPath) as? HotPlaceCafeImageCell {
            cell = imgCell
        }
        
        return cell
    }
    
    
}
