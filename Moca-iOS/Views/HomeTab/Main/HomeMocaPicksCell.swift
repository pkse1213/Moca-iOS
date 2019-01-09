//
//  MocaPicksCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 25..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeMocaPicksCell: UITableViewCell {
    var mocaPicks: [MocaPicks]?
    weak var delegate: ListViewCellDelegate?
    @IBOutlet weak var mocaPickCollectionView: UICollectionView!
    @IBOutlet var moreBtnImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        registerGesture()
    }
    
    private func setUpCollectionView() {
        self.mocaPickCollectionView.delegate = self
        self.mocaPickCollectionView.dataSource = self
    }
    
    private func registerGesture() {
        let moreBtnTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(moreAction(_:)))
        moreBtnImageView.addGestureRecognizer(moreBtnTapGestureRecognizer)
    }
    
    @objc func moreAction(_:UIImageView) {
        if let vc = UIStoryboard(name: "HomeTab", bundle: nil).instantiateViewController(withIdentifier: "MocaPicksListVC") as? MocaPicksListVC {
            delegate?.goToViewController(vc: vc)
        }
    }
    
}

extension HomeMocaPicksCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let cafeCell = mocaPickCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeMocaPicksCafeListCell", for: indexPath) as? HomeMocaPicksCafeListCell {
            cell = cafeCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let vc = UIStoryboard(name: "HomeTab", bundle: nil).instantiateViewController(withIdentifier: "MocaPicksCafeVC") as? MocaPicksCafeVC {
            delegate?.goToViewController(vc: vc)
        }
    }
    
}
