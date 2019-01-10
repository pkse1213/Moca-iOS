//
//  CommunityContentVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CommunityContentVC: UIViewController {
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    var review: CommunityReview? {
        didSet {
            setUpReviewData()
            initCommentData()
        }
    }
    var images: [ReviewImage]? {
        didSet { imageCollectionView.reloadData() }
    }
    var comments: [ReviewComment]? {
        didSet { contentTableView.reloadData() }
    }
    var reviewId = 0 {
        didSet { initReviewData() }
    }
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var cafeAddressLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var safeAreaView: UIView!
    @IBOutlet weak var textFieldViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var reviewContentViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageCntLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var contentTableView: UITableView!
    
    @IBOutlet weak var textBackgroundView: UIView!
    @IBOutlet weak var textSquareView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpListView()
        setUpView()
        registerGesture()
        checkVersion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setUpReviewData() {
        guard let review = review else { return }
        
        cafeNameLabel.text = review.cafeName
        cafeAddressLabel.text = review.cafeAddress
        if review.like {
            likeButton.setImage(#imageLiteral(resourceName: "commonHeartRed"), for: .normal)
        } else {
            likeButton.setImage(#imageLiteral(resourceName: "commonHeartBlank"), for: .normal)
        }
    }
    
    private func initReviewData() {
        CommunityReviewDetailService.shareInstance.getReviewDetail(reviewId: reviewId, token: token , completion: { (res) in
            self.review = res
            self.images = res.image
        }) { (err) in
            print("리뷰 상세 실패 \(err)")
        }
    }
    
    private func initCommentData() {
        guard let review = review else { return }
        
        CommunityReviewCommentService.shareInstance.getReviewComment(reviewId: review.reviewID, completion: { (res) in
            self.comments = res
            
            print("리뷰 댓글 성공")
        }) { (err) in
            print("리뷰 댓글 실패")
        }
    }
    
    private func setUpView() {
        textSquareView.applyBorder(width: 0.5, color: #colorLiteral(red: 0.8469749093, green: 0.8471175432, blue: 0.8469561338, alpha: 1))
        textBackgroundView.applyRadius(radius: 39/2)
        guard let images = images else { return }
        
        imageCntLabel.text = "1/\(images.count)"
    }
    
    private func setUpListView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        //        contentTableView.isScrollEnabled = false
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.applyRadius(radius: 10)
    }
    
    private func checkVersion() {
        if #available(iOS 11.0, tvOS 11.0, *) {
            if let topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.top, topPadding > 24 {
                safeAreaView.isHidden = false
            }
        }
    }
    
    @IBAction func likeAction(_ sender: UIButton) {
        guard let review = review else { return }
        CommunityReviewLikeService.shareInstance.postLike(reviewId: review.reviewID, token: token, completion: { (message) in
            print(review.reviewID)
            if self.likeButton.currentImage == #imageLiteral(resourceName: "commonHeartRed") {
                self.likeButton.setImage(#imageLiteral(resourceName: "commonHeartBlank"), for: .normal)
            } else if self.likeButton.currentImage == #imageLiteral(resourceName: "commonHeartBlank") {
                self.likeButton.setImage(#imageLiteral(resourceName: "commonHeartRed"), for: .normal)
            }
            print("좋아요 설정/취소 성공")
        }) { (err) in
            print(review.reviewID)
            print("좋아요 설정/취소 실패")
        }
    }
    
    private func registerGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasDragged(_:)))
        contentTableView.addGestureRecognizer(gesture)
        gesture.delegate = self
    }
    
    @objc func wasDragged(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: self.view)
            print(contentTableView.center.y)
            
            if contentTableView.center.y > self.view.frame.height+100 {
                contentTableView.center.y = contentTableView.center.y + translation.y
                
            } else {
                UIView.animate(withDuration: 0.5) {
                    self.contentTableView.center.y = self.view.frame.height/2+88-54
                    self.textSquareView.isHidden = false
                    self.textFieldViewBottomConstraint.constant = 0
//                    self.reviewContentViewTopConstraint.constant = 0
                    self.view.layoutIfNeeded()
                }
            }
            gestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        }
    }
    
    
}

extension CommunityContentVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            guard let comments = comments else { return 1 }
            return comments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            guard let review = review else { return cell }
            if let contentCell = contentTableView.dequeueReusableCell(withIdentifier: "CommunityContentCell") as? CommunityContentCell {
                contentCell.review = review
                cell = contentCell
            }
        } else {
            // 댓글이 없을 때
            guard let comments = comments else {
                if let emptyCell = contentTableView.dequeueReusableCell(withIdentifier: "EmptyCommentCell") {
                    cell = emptyCell
                }
                return cell
            }
            if let commentCell = contentTableView.dequeueReusableCell(withIdentifier: "CommunityCommentCell") as? CommunityCommentCell {
                commentCell.comment = comments[indexPath.row]
                cell = commentCell
            }
        }
        return cell
    }
}

extension CommunityContentVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lenght = imageCollectionView.frame.width
        return CGSize(width: lenght, height: lenght)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
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


extension CommunityContentVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let images = images else { return }
        
        if scrollView is UICollectionView {
            let indexPath = imageCollectionView.indexPathForItem(at: scrollView.contentOffset)
            if let index = indexPath?.item {
                imageCntLabel.text = "\(index+1)/\(images.count)"
            }
            
        }
//        else if scrollView is UITableView {
//            print(contentTableView.center.y)
//            if scrollView.contentOffset.y > 0.0 {
//                UIView.animate(withDuration: 0.5) {
//                    self.textSquareView.isHidden = false
//                    self.textFieldViewBottomConstraint.constant = 0
//                    self.reviewContentViewTopConstraint.constant = 0
//                    self.view.layoutIfNeeded()
//                }
//            }
//            if scrollView.contentOffset.y == 0.0 {
//                UIView.animate(withDuration: 0.5) {
//
//                    self.textFieldViewBottomConstraint.constant = -54
//                    self.reviewContentViewTopConstraint.constant = 418.67
//                    self.view.layoutIfNeeded()
//                }
//                self.textSquareView.isHidden = true
//            }
//
//        }
    }
}

extension CommunityContentVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
