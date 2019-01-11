//
//  CommunitySearchVC.swift
//  Moca-iOS
//
//  Created by 조수민 on 04/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class CommunitySearchVC: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    // 전체, 카페명, 위치 중 선택한 ㄱㅔ 뭔지를 나타내는 flag,,?
    var selectTabPosition = 0 {
        didSet { searchResultTableView.reloadData() }
    }
    // 탭 아래 선 부분
    @IBOutlet weak var allTabView: UIView!
    @IBOutlet weak var cafeTabView: UIView!
    @IBOutlet weak var locationTabView: UIView!
    // 탭 버튼 부분
    @IBOutlet weak var allTabButton: UIButton!
    @IBOutlet weak var cafeTabButton: UIButton!
    @IBOutlet weak var locationTabButton: UIButton!
    
    @IBOutlet weak var beforeSearchView: UIView!
    @IBOutlet weak var hotCafeCollectionView: UICollectionView!
    @IBOutlet weak var popularUserCollectionView: UICollectionView!
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    var unit : CGFloat = 0
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    var keyword = "" {
        didSet { initSearchData() }
    }
    var bestCafes: [BestCafe]? {
        didSet { hotCafeCollectionView.reloadData() }
    }
    var bestUsers: [BestUser]? {
        didSet { popularUserCollectionView.reloadData() }
    }
    var searchResults: CommunitySearchResult? {
        didSet { searchResultTableView.reloadData()
            print("dd")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpTextField()
        setUpCollectionView()
        initBeforeData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // 카페명 검색 결과 설정 - 최신 리뷰 설정하기 위해
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        unit = self.view.frame.width/375
    }
    
    private func initBeforeData() {
        BestReviewService.shareInstance.getBestReview(flag: 1, token: token, completion: { (res) in
            self.bestCafes = res
            print("-----\(res.count)")
        }) { (err) in
            print("인기 리뷰 조회 실패 \(err)")
        }
        BestUserService.shareInstance.getBestUser(token: token, completion: { (res) in
            self.bestUsers = res.filter({ $0.auth == false })
        }) { (err) in
            print("인기 유저 조회 실패 \(err)")
        }
    }
    
    // 이번주 인기 카페 설정
    private func setUpCollectionView() {
        popularUserCollectionView.delegate = self
        popularUserCollectionView.dataSource = self
        
        hotCafeCollectionView.dataSource = self
        hotCafeCollectionView.delegate = self
    }
    
    // tableView delegate랑 dataSource 설정
    private func setUpTableView() {
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
    }
    
    // back action
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Tab Action
    @IBAction func tabAction(_ sender: UIButton) {
        selectTabPosition = sender.tag
        initSearchData()
        switch selectTabPosition {
        case 0:
            // Tab 아래 선택바 부분 색상 변경
            allTabView.backgroundColor = UIColor(red: 225/255, green: 178/255, blue: 163/255, alpha: 1.0)
            cafeTabView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
            locationTabView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
            
            // Tab 버튼 글씨 색상 변경
            allTabButton.setTitleColor(#colorLiteral(red: 0.8823529412, green: 0.6980392157, blue: 0.6392156863, alpha: 1), for: .normal)
            cafeTabButton.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
            locationTabButton.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
        case 1:
            allTabView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
            cafeTabView.backgroundColor = UIColor(red: 225/255, green: 178/255, blue: 163/255, alpha: 1.0)
            locationTabView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
            
            allTabButton.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
            cafeTabButton.setTitleColor(#colorLiteral(red: 0.8823529412, green: 0.6980392157, blue: 0.6392156863, alpha: 1), for: .normal)
            locationTabButton.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
        case 2:
            allTabView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
            cafeTabView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
            locationTabView.backgroundColor = UIColor(red: 225/255, green: 178/255, blue: 163/255, alpha: 1.0)
            
            allTabButton.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
            cafeTabButton.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
            locationTabButton.setTitleColor(#colorLiteral(red: 0.8823529412, green: 0.6980392157, blue: 0.6392156863, alpha: 1), for: .normal)
            
        default:
            break
        }
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let keyword = textField.text else { return }
        if keyword == "" {
            beforeSearchView.isHidden = false
            self.initBeforeData()
            return
        } else {
            beforeSearchView.isHidden = true
            self.keyword = keyword
        }
    }
    
    private func initSearchData() {
        CommunitySearchResultService.shareInstance.getHomeSearchResult(keyword: keyword, token: token, completion: { (res) in
            self.searchResults = res
           
        }) { (err) in
            self.searchResults = nil
            print("검색 결과 실패\(err)")
        }
    }
    
    private func setUpTextField() {
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: UIControl.Event.editingChanged)
        // TextField paddingLeft 설정
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: searchTextField.frame.height))
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = UITextField.ViewMode.always
    }
}

// TableView Delegate, DataSource
extension CommunitySearchVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    // section
    // 0 : 인기 리뷰
    // 1 : 최신 리뷰
    // 2 : 사용자
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let searchResult = searchResults else { return 0 }
        switch selectTabPosition {
        case 0:
            switch section {
            case 0:
                if searchResult.popularReviewList.count > 0 { return 1 }
                else { return 0 }
            case 2:
                if searchResult.searchUserList.count > 0 { return searchResult.searchUserList.count + 1 }
                else { return 0 }
            default:
                return 0
            }
        case 1:
            switch section {
            case 0:
                if searchResult.popularReviewList.count > 0 { return 1 }
                else { return 0 }
            case 1:
                if searchResult.reviewListOrderByLatest.count > 0 { return 1 }
                else { return 0 }
            default:
                return 0
            }
        case 2:
            switch section {
            case 2:
                if searchResult.searchUserList.count > 0 { return searchResult.searchUserList.count + 1 }
                else { return 0 }
            default:
                return 0
            }
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let searchResult = searchResults else { return cell }
        switch indexPath.section {
        case 0:
            if let reviewCell = tableView.dequeueReusableCell(withIdentifier: "CommunitySearchPopularReviewCell") as? CommunitySearchPopularReviewCell {
                reviewCell.reviews = searchResult.popularReviewList
                reviewCell.delegate = self
                cell = reviewCell
            }
        case 1:
            if let reviewCell = tableView.dequeueReusableCell(withIdentifier: "CommunitySearchRecentReviewCell") as? CommunitySearchRecentReviewCell {
                reviewCell.reviews = searchResult.reviewListOrderByLatest
                reviewCell.delegate = self
                cell = reviewCell
            }
        case 2:
            switch indexPath.row {
            case 0:
                if let headerCell = tableView.dequeueReusableCell(withIdentifier: "userHeaderCell") {
                    cell = headerCell
                }
            default:
                if let userCell = tableView.dequeueReusableCell(withIdentifier: "CommunitySearchPeopleCell") as? CommunitySearchPeopleCell {
                    userCell.user = searchResult.searchUserList[indexPath.row-1]
                    cell = userCell
                }
            }
        default:
            break
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            guard let user = searchResults?.searchUserList[indexPath.row-1] else { return }
            if let vc = UIStoryboard(name: "CommunityTab", bundle: nil).instantiateViewController(withIdentifier: "CommunityUserFeedVC") as? CommunityUserFeedVC {
                vc.userId = user.userID
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

// 검색 전 화면 설정 & 카페명 검색 결과 설정
extension CommunitySearchVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // 최신 리뷰 셀 크기 설정
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
//        if collectionView == self.recentReviewCollectionView {
//            return CGSize(width:120*unit , height: 120*unit)
//        }
//        else
//        if collectionView == self.hotCafeCollectionView {
//            return CGSize(width:140 , height: 200)
//        }
//        else if collectionView == self.popularUserCollectionView {
//            return CGSize(width: 136, height: 173)
//        }
//        else {
//            return CGSize(width: 170, height: 170)
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.hotCafeCollectionView {
            guard let bestCafes = bestCafes else { return 0 }
            print("bestCafes.count\(bestCafes.count)")
            return bestCafes.count
        }
        else if collectionView == self.popularUserCollectionView {
            guard let bestUsers = bestUsers else { return 0 }
            return bestUsers.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if collectionView == hotCafeCollectionView {
            guard let bestCafes = bestCafes else { return cell }
            if let bestCafecell = hotCafeCollectionView.dequeueReusableCell(withReuseIdentifier: "HotCafeCollectionViewCell", for: indexPath) as? HotCafeCollectionViewCell {
                bestCafecell.bestCafe = bestCafes[indexPath.item]
                cell = bestCafecell
            }
        }
        else if collectionView == popularUserCollectionView {
            guard let bestUsers = bestUsers else { return cell }
            if let userCell = popularUserCollectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as? PopularCollectionViewCell {
                userCell.user = bestUsers[indexPath.item]
                cell = userCell
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == hotCafeCollectionView {
            guard let bestCafe = bestCafes?[indexPath.item] else { return }
            if let vc = UIStoryboard(name: "LocationTab", bundle: nil).instantiateViewController(withIdentifier: "LocationCafeDetailVC") as? LocationCafeDetailVC {
                vc.cafeId = bestCafe.cafeID
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else if collectionView == popularUserCollectionView {
            guard let bestUser = bestUsers?[indexPath.item] else { return }
            if let vc = UIStoryboard(name: "CommunityTab", bundle: nil).instantiateViewController(withIdentifier: "CommunityUserFeedVC") as? CommunityUserFeedVC {
                vc.userId = bestUser.userID
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension CommunitySearchVC: ListViewCellDelegate {
    func goToViewController(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CommunitySearchVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        beforeSearchView.isHidden = true
        
        return true
    }
}

