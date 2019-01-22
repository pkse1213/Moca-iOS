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
    var cafes: [RankingCafe]? {
        didSet { rankingCollectionView.reloadData() }
    }
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic2VldW5pIiwiaXNzIjoiRG9JVFNPUFQifQ.56TYkh--ZSO7duJvdVLf-BOgFBPCG9fdDRGUGTmtC68"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        initData()
        setupNaviBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setupNaviBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NanumGothicBold", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.title = "Ranking"
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
}

extension HomeRankingListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let unit = self.view.frame.width / 375
        return CGSize(width:175*unit , height: 236*unit)
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
