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
    
    var scrapCafeList : [ScrapCafeData]?
    var delegate: ListViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpCollectionView()
    }

    private func setUpCollectionView() {
        cafeImageCollectionView.delegate = self
        cafeImageCollectionView.dataSource = self
        
    }
    
}

extension LikeCafeCell : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let scrapCafeList = scrapCafeList else { return 0 }
        
        return scrapCafeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        guard let image = scrapCafeList?[indexPath.row] else { return cell }
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeCafeImageCell", for: indexPath) as! LikeCafeImageCell
            imageCell.likeCafeImageView.imageFromUrl(image.cafeImgURL[0].cafeImgUrl, defaultImgPath: "")
            print(image.cafeImgURL[0].cafeImgUrl)
        
        cell = imageCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       guard let image = scrapCafeList?[indexPath.row] else { return }
        if let vc = UIStoryboard(name: "LocationTab", bundle: nil).instantiateViewController(withIdentifier: "LocationCafeDetailVC") as? LocationCafeDetailVC {
            vc.cafeId = image.cafeID
            delegate?.goToViewController(vc: vc)
        }
    }

    
}
