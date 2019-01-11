//
//  CafeDetailImageCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 2..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class CafeDetailImageListCell: UITableViewCell {
    var images:[CafeDetailImage]? {
        didSet { setUpProgress()}
    }
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
        squareView.applyRadius(radius: 10)
    }
    
    private func setUpProgress() {
        guard let images = images else {return}
        progressUnit = Float(1)/Float(images.count)
        scrollProgressView.progress = progressUnit
        
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
        guard let images = images else { return 0 }
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        guard let image = images?[indexPath.item] else { return cell }
        if let imageCell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "CafeDetailImageCell", for: indexPath) as? CafeDetailImageCell {
             imageCell.cafeImageView.imageFromUrl(image.cafeImgURL, defaultImgPath: "")
            cell = imageCell
        }
        return cell
    }
    
    
}

extension CafeDetailImageListCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let images = images else { return }
        if scrollView is UICollectionView {
            scrollProgressView.progress = Float(scrollView.contentOffset.x+scrollView.frame.width) / Float(scrollView.frame.width*CGFloat(images.count))
        }
    }
}
