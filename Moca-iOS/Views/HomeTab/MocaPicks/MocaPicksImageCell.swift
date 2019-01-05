//
//  MocaPicksImageCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 6..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class MocaPicksImageCell: UITableViewCell {
    var progressUnit: Float = 0
    @IBOutlet weak var cafeImageCollectionView: UICollectionView!
    @IBOutlet weak var scrollProgressView: UIProgressView!
    @IBOutlet weak var squareView: UIView!
    
    let colors = [#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1),#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1),#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1),#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1),#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpListView()
    }

    private func setUpListView() {
        progressUnit = Float(1)/Float(colors.count)
        scrollProgressView.progress = progressUnit
        
        cafeImageCollectionView.delegate = self
        cafeImageCollectionView.dataSource = self
        cafeImageCollectionView.isPagingEnabled = true
        squareView.applyRadius(radius: 10)
    }
    
}

extension MocaPicksImageCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.frame.width
        return CGSize(width: width , height: 228*width/375)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let imageCell = cafeImageCollectionView.dequeueReusableCell(withReuseIdentifier: "CommunityContentImageCell", for: indexPath) as? CommunityContentImageCell {
            imageCell.contentImageView.image = UIImage(named: "sample\(indexPath.item+1)")
            cell = imageCell
        }
        
        return cell
    }
    
}

extension MocaPicksImageCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView is UICollectionView {
            scrollProgressView.progress = Float(scrollView.contentOffset.x+scrollView.frame.width) / Float(scrollView.frame.width*CGFloat(colors.count))
        }
    }
}
