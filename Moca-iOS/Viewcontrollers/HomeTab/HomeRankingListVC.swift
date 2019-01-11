//
//  HomeRankingListVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeRankingListVC: UIViewController {

    @IBOutlet weak var rankingCollectionView: UICollectionView!
    var unit: CGFloat = 0
    var cafes: [RankingCafe]? {
        didSet { rankingCollectionView.reloadData() }
    }
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func initData() {
        RankingCafeService.shareInstance.getRankingCafe(length: -1, token: token, completion: { (res) in
            self.cafes = res
        }) { (err) in
            print("랭킹 조회 실패 \(err)")
        }
    }
    
    private func setUpCollectionView() {
        self.rankingCollectionView.delegate = self
        self.rankingCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        unit = (self.rankingCollectionView.frame.width/2-2)/175
    }
}

extension HomeRankingListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width:175*unit , height: 238*unit)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cafes = cafes else { return 0 }
        return cafes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        guard let cafe = cafes?[indexPath.row] else { return cell }
        if let cafeCell = rankingCollectionView.dequeueReusableCell(withReuseIdentifier: "RankingCafeCell", for: indexPath) as? RankingCafeCell {
            cafeCell.rankNumLabel.text = "\(indexPath.row+1)"
            cafeCell.cafe = cafe
            
            cell = cafeCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cafe = cafes?[indexPath.row] else { return }
        if let vc = UIStoryboard(name: "LocationTab", bundle: nil).instantiateViewController(withIdentifier: "LocationCafeDetailVC") as? LocationCafeDetailVC {
            vc.cafeId = cafe.cafeID
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
