//
//  CafeDetailImageCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 2..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class CafeDetailImageListCell: UITableViewCell {
    
    @IBOutlet var squareView: UIView!
    @IBOutlet var imageCollectionView: UICollectionView!
    @IBOutlet var scrollProgressView: UIProgressView!
    var progressUnit: Float = 0
   
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        setUpView()
    }
    
    private func setUpView() {
        progressUnit = Float(1)/Float(8)
        scrollProgressView.progress = progressUnit
        squareView.applyRadius(radius: 10)
    }
    private func setUpCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }
}

extension CafeDetailImageListCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: imageCollectionView.frame.width , height: imageCollectionView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let imageCell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "CafeDetailImageCell", for: indexPath) as? CafeDetailImageCell {
            imageCell.cafeImageView.image = UIImage(named: "sample\(indexPath.item+1)")
            cell = imageCell
        }
        return cell
    }
    
    
}

extension CafeDetailImageListCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView is UICollectionView {
            scrollProgressView.progress = Float(scrollView.contentOffset.x+scrollView.frame.width) / Float(scrollView.frame.width*CGFloat(8))
        }
    }
}
