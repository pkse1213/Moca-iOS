//
//  ReviewVC.swift
//  Moca-iOS
//
//  Created by 조수민 on 05/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class ReviewVC: UIViewController {
    
    @IBOutlet var popularReviewCollection: UICollectionView!
    @IBOutlet var recentReviewCollection: UICollectionView!
    
    var unit : CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCafeResultView()
    }
    
    // 카페명 검색 결과 설정
    private func setUpCafeResultView() {
        popularReviewCollection.dataSource = self
        popularReviewCollection.delegate = self
        recentReviewCollection.dataSource = self
        recentReviewCollection.delegate = self
    }
    
    // 카페명 검색 결과 설정 - 최신 리뷰 설정하기 위해
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        unit = self.view.frame.width/375
    }

}

extension ReviewVC : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.popularReviewCollection {
            return 9
        }
        else {
            return 25
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.popularReviewCollection {
            let cell = popularReviewCollection.dequeueReusableCell(withReuseIdentifier: "PopularReviewCell", for: indexPath) as! PopularReviewCell
            
            return cell
        }
        else {
            let cell = recentReviewCollection.dequeueReusableCell(withReuseIdentifier: "RecentReviewCell", for: indexPath) as! RecentReviewCell
            
            return cell
        }
    }
    
    // 최신 리뷰 셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.recentReviewCollection {
            return CGSize(width:120*unit , height: 120*unit)
        }
        else {
            return CGSize(width: 170, height: 170)
        }
    }
}
