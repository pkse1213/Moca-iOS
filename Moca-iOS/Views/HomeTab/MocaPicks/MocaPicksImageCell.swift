//
//  MocaPicksImageCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 6..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class MocaPicksImageCell: UITableViewCell {
    
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var cafeAddressLabel: UILabel!
    @IBOutlet weak var cafeImageCollectionView: UICollectionView!
    @IBOutlet weak var scrollProgressView: UIProgressView!
    @IBOutlet weak var squareView: UIView!
    @IBOutlet weak var scrapButton: UIButton!
    
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    var progressUnit: Float = 0
    var cafeId = 0
    var isScrap = true
    var cafeImages: [MocaPicksImage]? {
        didSet {
            setUpProgress()
            cafeImageCollectionView.reloadData()
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpListView()
        
        switch isScrap {
        case true:
            self.scrapButton.setImage(#imageLiteral(resourceName: "commonScrapFilled"), for: .normal)
        case false:
            self.scrapButton.setImage(#imageLiteral(resourceName: "detailviewScrap"), for: .normal)
        default:
            break
        }
    }

    private func setUpListView() {
        cafeImageCollectionView.delegate = self
        cafeImageCollectionView.dataSource = self
        cafeImageCollectionView.isPagingEnabled = true
        squareView.applyRadius(radius: 10)
    }
    
    private func setUpProgress() {
        guard let cafeImages = cafeImages else { return }
        progressUnit = Float(1)/Float(cafeImages.count)
        scrollProgressView.progress = progressUnit
    }
    
    @IBAction func scrapAction(_ sender: UIButton) {
        switch isScrap {
        case true:
            CafeScrapService.shareInstance.deleteCafeScrap(cafeId: cafeId, token: token, completion: { (message) in
                self.scrapButton.setImage(#imageLiteral(resourceName: "detailviewScrap"), for: .normal)
                self.isScrap = !self.isScrap
            }) { (err) in
                print("언팔로우 실패 \(err)")
            }
        case false:
            CafeScrapService.shareInstance.postCafeScrap(cafeId: cafeId, token: token, completion: { (message) in
                self.isScrap = !self.isScrap
                self.scrapButton.setImage(#imageLiteral(resourceName: "commonScrapFilled"), for: .normal)
            }) { (err) in
                print("팔로우 실패 \(err)")
            }
        default:
            break
        }
    }
}

extension MocaPicksImageCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.frame.width
        return CGSize(width: width , height: 228*width/375)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cafeImages = cafeImages else { return 0 }
        return cafeImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        guard let cafeImage = cafeImages?[indexPath.item] else { return cell }
        if let imageCell = cafeImageCollectionView.dequeueReusableCell(withReuseIdentifier: "CommunityContentImageCell", for: indexPath) as? CommunityContentImageCell {
            imageCell.contentImageView.imageFromUrl(cafeImage.evaluatedCafeImgURL, defaultImgPath: "")
            cell = imageCell
        }
        return cell
    }
}

extension MocaPicksImageCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let cafeImages = cafeImages else { return }
        if scrollView is UICollectionView {
            scrollProgressView.progress = Float(scrollView.contentOffset.x+scrollView.frame.width) / Float(scrollView.frame.width*CGFloat(cafeImages.count))
        }
    }
}
