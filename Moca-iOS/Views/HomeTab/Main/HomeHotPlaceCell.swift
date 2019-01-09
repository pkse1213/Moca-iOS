//
//  CenceptCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 25..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeHotPlaceCell: UITableViewCell {
    @IBOutlet var moreBtnImageView: UIImageView!
    @IBOutlet weak var hotPlaceCollectionView: UICollectionView!
    var hotPlaceNames: [HotPlaceName]?
    var delegate: ListViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        registerGesture()
    }
    
    private func setUpCollectionView() {
        self.hotPlaceCollectionView.delegate = self
        self.hotPlaceCollectionView.dataSource = self
    }
    
    private func registerGesture() {
        let moreBtnTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(moreAction(_:)))
        moreBtnImageView.addGestureRecognizer(moreBtnTapGestureRecognizer)
    }
    
    @objc func moreAction(_:UIImageView) {
        if let vc = UIStoryboard(name: "HomeTab", bundle: nil).instantiateViewController(withIdentifier: "HotPlaceVC") as? HotPlaceVC {
            delegate?.goToViewController(vc: vc)
        }
    }
}

extension HomeHotPlaceCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let hotPlaceNames = hotPlaceNames else { return 0 }
        return hotPlaceNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        guard let hotPlaceName = hotPlaceNames?[indexPath.item] else { return cell }
        if let hotPlaceCell = hotPlaceCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeHotPlaceNameCell", for: indexPath) as? HomeHotPlaceNameCell {
            hotPlaceCell.hotPlaceName = hotPlaceName
            cell = hotPlaceCell
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
