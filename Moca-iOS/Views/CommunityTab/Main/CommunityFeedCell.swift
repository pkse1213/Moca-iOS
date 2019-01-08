//
//  CommunityFeedCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CommunityFeedCell: UITableViewCell {
    var review: CommunityReview? {
        didSet { setUpData() }
    }
    var images: [ReviewImage]?
    var navigationController: UINavigationController?
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likeCntLabel: UILabel!
    @IBOutlet weak var commentCntLabel: UILabel!
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var cafeAddressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var reviewContentLabel: UILabel!
    @IBOutlet weak var cntBackgroundView: UIView!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var imageCntLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        setUpView()
    }
    
    private func setUpData() {
        guard let review = review else { return }
        nameLabel.text = review.userID
        cafeNameLabel.text = review.cafeName
        cafeAddressLabel.text = review.cafeAddress
        likeCntLabel.text = "\(review.likeCount)"
        commentCntLabel.text = "\(review.commentCount)"
        reviewContentLabel.text = review.reviewTitle
        timeLabel.text = review.time
        
        images = review.image
    }
    
    private func setUpCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.isPagingEnabled = true
    }
    
    private func setUpView() {
        profileImageView.applyRadius(radius: 20)
        cntBackgroundView.applyBorder(width: 0.5, color: #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1))
        cntBackgroundView.applyRadius(radius: cntBackgroundView.frame.height/2)
        if let images = images {
            imageCntLabel.text = "1/\(images.count)"
        }
    }
    
    @IBAction func goToCommentAction(_ sender: UIButton) {
    }
    @IBAction func likeAction(_ sender: UIButton) {
    }
    @IBAction func moreNotifyAction(_ sender: UIButton) {
    }
    @IBAction func moreLookAction(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "CommunityTab", bundle: nil).instantiateViewController(withIdentifier: "CommunityContentVC") as? CommunityContentVC {
            vc.review = review
            vc.images = images
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CommunityFeedCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lenght = imageCollectionView.frame.width
        return CGSize(width: lenght, height: lenght)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let images = images else { return 0 }
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let imageCell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "CommunityContentImageCell", for: indexPath) as? CommunityContentImageCell {
            imageCell.contentImageView.image = UIImage(named: "sample\(indexPath.item+1)")
            cell = imageCell
        }
        return cell
    }
    
}

extension CommunityFeedCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let images = images else { return }
        if scrollView is UICollectionView {
            let indexPath = imageCollectionView.indexPathForItem(at: scrollView.contentOffset)
            if let index = indexPath?.item {
                imageCntLabel.text = "\(index+1)/\(images.count)"
            }
            
        }
    }
}

