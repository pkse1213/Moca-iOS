//
//  CommunitySearchRecentReviewCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 10..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class CommunitySearchRecentReviewCell: UITableViewCell {

   
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    var delegate: ListViewCellDelegate?
    var reviews: [SearchReview]? {
        didSet { reviewCollectionView.reloadData() }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func setUpCollectionView() {
        reviewCollectionView.dataSource = self
        reviewCollectionView.delegate = self
    }
    
}
extension CommunitySearchRecentReviewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let reviews = reviews else { return 0 }
        return reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let reviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentReviewCell", for: indexPath) as? RecentReviewCell {
            cell = reviewCell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let review = reviews?[indexPath.row] else { return }
        if let vc = UIStoryboard(name: "CommunityTab", bundle: nil).instantiateViewController(withIdentifier: "CommunityContentVC") as? CommunityContentVC {
            vc.reviewId = review.reviewID
            delegate?.goToViewController(vc: vc)
        }
    }
}
