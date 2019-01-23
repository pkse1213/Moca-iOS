//
//  ViewController.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 24..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeTabMainVC: UIViewController {
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var homeTabTableView: UITableView!
    @IBOutlet weak var noticeImageView: UIImageView!
    
    var networkFailView: NetworkFailView!
    var mocaPicks: [MocaPicks]? {
        didSet { homeTabTableView.reloadData() }
    }
    var hotPlaceNames: [HotPlaceName]? {
        didSet { homeTabTableView.reloadData() }
    }
    var rankingCafes: [RankingCafe]? {
        didSet { homeTabTableView.reloadData() }
    }
    var mocaPlusSubject: [MocaPlusSubject]? {
        didSet { homeTabTableView.reloadData() }
    }
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic2VldW5pIiwiaXNzIjoiRG9JVFNPUFQifQ.56TYkh--ZSO7duJvdVLf-BOgFBPCG9fdDRGUGTmtC68"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        initData {
            self.failNetwork()
        }
        setUpTableView()
        registerGesture()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setUpView() {
        networkFailView =  NetworkFailView.instanceFromXib() as? NetworkFailView
        networkFailView.delegate = self
        
        searchBarView.applyRadius(radius: 5)
        searchBarView.applyBorder(width: 1.0, color: #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1))
    }
    
    private func setUpTableView() {
        self.homeTabTableView.delegate = self
        self.homeTabTableView.dataSource = self
    }
    
    private func initData(error : @escaping() -> Void) {
        MocaPicksCafeService.shareInstance.getMocaPicksCafe(length: 3, token: token, completion: { (res) in
            self.mocaPicks = res
        }) { (err) in
            print("홈 모카픽스 실패 \(err)")
            error()
        }
        HotPlaceNameService.shareInstance.getRankingCafe(token: token, completion: { (res) in
            self.hotPlaceNames = res
        }) { (err) in
            print("홈 핫플레이스 실패 \(err)")
            error()
        }
        RankingCafeService.shareInstance.getRankingCafe(length: 3, token: token, completion: { (res) in
            self.rankingCafes = res
        }) { (err) in
            print("홈 랭킹 실패 \(err)")
            error()
        }
        MocaPlusSubjectService.shareInstance.getMocaPlusSubject(length: 3, token: token, completion: { (res) in
            self.mocaPlusSubject = res
        }) { (err) in
            print("홈 모카플러스 실패 \(err)")
            error()
        }
    }
    
    private func failNetwork() {
        self.view.addSubview(networkFailView)
    }
    
    private func registerGesture() {
        let searchTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToSearchAction(_:)))
        searchBarView.addGestureRecognizer(searchTapGestureRecognizer)
        
        let noticeTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToNoticeActon(_:)))
        noticeImageView.addGestureRecognizer(noticeTapGestureRecognizer)
        
    }
    
    @objc func goToNoticeActon(_: UIImageView) {
        if let vc = UIStoryboard(name: "HomeTab", bundle: nil).instantiateViewController(withIdentifier: "HomeNoticeVC") as? HomeNoticeVC {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func goToSearchAction(_: UIImageView) {
        if let vc = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "HomeSearchVC") as? HomeSearchVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeTabMainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = mocaPicks, let _ = hotPlaceNames, let _ = rankingCafes, let _ = mocaPlusSubject else { return 0 }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        guard let _ = mocaPicks, let hotPlaceNames = hotPlaceNames, let rankingCafes = rankingCafes, let mocaPlusSubject = mocaPlusSubject else { return cell }
        
        switch indexPath.section {
        case 0:
            if let mocaPicksCell = homeTabTableView.dequeueReusableCell(withIdentifier: "HomeMocaPicksCell") as? HomeMocaPicksCell {
                mocaPicksCell.mocaPicks = mocaPicks
                mocaPicksCell.delegate = self
                cell = mocaPicksCell
            }
        case 1:
            if let hotPlaceCell = homeTabTableView.dequeueReusableCell(withIdentifier: "HomeHotPlaceCell") as? HomeHotPlaceCell {
                hotPlaceCell.hotPlaceNames = hotPlaceNames
                hotPlaceCell.delegate = self
                cell = hotPlaceCell
            }
        case 2:
            if let rankingCell = homeTabTableView.dequeueReusableCell(withIdentifier: "HomeRankingCell") as? HomeRankingCell {
                rankingCell.rankingCafes = rankingCafes
                rankingCell.delegate = self
                cell = rankingCell
            }
        case 3:
            if let mocaPlusCell = homeTabTableView.dequeueReusableCell(withIdentifier: "HomeMocaPlusCell") as? HomeMocaPlusCell {
                mocaPlusCell.mocaPlusSubject = mocaPlusSubject
                mocaPlusCell.delegate = self
                cell = mocaPlusCell
            }
        default:
            return cell
        }
        return cell
    }
    
}

extension HomeTabMainVC: ListViewCellDelegate {
    
    func goToViewController(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeTabMainVC: NetworkFailDelegate {
    func retryAction() {
        initData { self.failNetwork() }
        self.networkFailView.removeFromSuperview()
    }
}
