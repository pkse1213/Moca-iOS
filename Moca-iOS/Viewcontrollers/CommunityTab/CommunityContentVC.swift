//
//  CommunityContentVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CommunityContentVC: UIViewController {
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic2VldW5pIiwiaXNzIjoiRG9JVFNPUFQifQ.56TYkh--ZSO7duJvdVLf-BOgFBPCG9fdDRGUGTmtC68"
    var review: CommunityReview? {
        didSet {
            setUpReviewData()
            initCommentData()
        }
    }
    var images: [ReviewImage]? {
        didSet { imageCollectionView.reloadData()
            if let images = images {
                 imageCntLabel.text = "1/\(images.count)"
                print("images.count\(images.count)")
                if images.count <= 1 {
                    cntBackgroundView.isHidden = true
                } else {
                    cntBackgroundView.isHidden = false
                    imageCntLabel.text = "1/\(images.count)"
                }
            }
        }
    }
    var comments: [ReviewComment]? {
        didSet { contentTableView.reloadData() }
    }
    var reviewId = 0
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var cafeAddressLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var safeAreaView: UIView!
    @IBOutlet weak var textFieldViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var reviewContentViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageCntLabel: UILabel!
    @IBOutlet weak var cntBackgroundView: UIView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var contentTableView: UITableView!
    
    @IBOutlet weak var textBackgroundView: UIView!
    @IBOutlet weak var textSquareView: UIView!
    @IBOutlet weak var messageSenderButton: UIButton!
    @IBOutlet weak var messageTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initReviewData()
        setUpListView()
        setUpView()
        registerGesture()
        checkVersion()
        setupTextView()
        cntBackgroundView.applyBorder(width: 0.5, color: #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1))
        cntBackgroundView.applyRadius(radius: cntBackgroundView.frame.height/2)
        setupNaviBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setupNaviBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NanumGothicBold", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        let button: UIButton = UIButton()
        button.setImage(#imageLiteral(resourceName: "commonBackBlack"), for: .normal)
        button.addTarget(self, action: #selector(backAction(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func backAction(_: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUpReviewData() {
        guard let review = review else { return }
        cafeAddressLabel.text = review.cafeAddress
        cafeNameLabel.text = review.cafeName
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
            self.navigationItem.title = res.cafeName
        }) { (err) in
            print("리뷰 상세 실패 \(err)")
        }
    }
    
    private func initCommentData() {
        guard let review = review else { return }
        print(review.reviewID)
        CommunityReviewCommentService.shareInstance.getReviewComment(reviewId: review.reviewID, token: token, completion: { (res) in
            self.comments = res
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
    
    @IBAction func senderMessageAction(_ sender: UIButton) {
        guard let review = review else { return }
        CommunityCommentService.shareInstance.postWriteComment(reviewId: review.reviewID, token: token, content: messageTextView.text, completion: { (message) in
            self.initCommentData()
            self.messageTextView.text = ""
        }) { (err) in
            print("댓글 달기 실패\(err)")
        }
        messageTextView.resignFirstResponder()
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
            guard let comments = comments else { return 0 }
            if comments.count == 0 { return 1 }
            else { return comments.count }
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
            guard let comments = comments else { return cell }
            if comments.count == 0 {
                if let emptyCell = contentTableView.dequeueReusableCell(withIdentifier: "EmptyCommentCell") {
                    cell = emptyCell
                }
                return cell
            } else {
                if let commentCell = contentTableView.dequeueReusableCell(withIdentifier: "CommunityCommentCell") as? CommunityCommentCell {
                    commentCell.comment = comments[indexPath.row]
                    cell = commentCell
                }
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
        guard let images = images else { return 0 }
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        guard let images = images else { return cell }
        
        if let imageCell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "CommunityContentImageCell", for: indexPath) as? CommunityContentImageCell {
            imageCell.image = images[indexPath.item]
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

extension CommunityContentVC: UITextViewDelegate {
    private func setupTextView() {
        messageTextView.delegate = self
//        let tapDidsmiss = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        self.messageTableView.addGestureRecognizer(tapDidsmiss)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.textFieldViewBottomConstraint.constant = keyboardHeight - 34
            self.reviewContentViewTopConstraint.constant = 0
            
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.textFieldViewBottomConstraint.constant = 0
    }
}
