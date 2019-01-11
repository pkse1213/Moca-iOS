//
//  HomeSearchVC.swift
//  Moca-iOS
//
//  Created by 조수민 on 2018. 12. 28..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeSearchVC: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    // 전체, 카페명, 위치 중 선택한 ㄱㅔ 뭔지를 나타내는 flag,,?
    var selectTabPosition = 0
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
    @IBOutlet weak var recommendCollectionView: UICollectionView!
    var keyword = "" {
        didSet { initSearchData() }
    }
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xknd"
    var bestCafes: [BestCafe]? {
        didSet { hotCafeCollectionView.reloadData() }
    }
    var hotPlaces: [RecommendHotPlace]? {
        didSet { recommendCollectionView.reloadData() }
    }
    var searchResults: [HomeSearchResult]? {
        didSet { searchResultTableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBeforeData()
        setUpTableView()
        setUpTextField()
        setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        beforeSearchView.isHidden = true
        guard let keyword = textField.text else { return }
        if keyword == "" {
            beforeSearchView.isHidden = false
            return
        } else {
             self.keyword = keyword
        }
    }
    
    private func initSearchData() {
        HomeSearchResultService.shareInstance.getHomeSearchResult(keyword: keyword, token: token, completion: { (res) in
            if self.selectTabPosition == 1 {
                self.searchResults = res.filter({ $0.type == false })
            } else if self.selectTabPosition == 2 {
                self.searchResults = res.filter({ $0.type == true })
            } else {
                self.searchResults = res
            }
        }) { (err) in
            self.searchResults = []
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
    
    // 이번주 인기 카페 설정
    private func setUpCollectionView() {
        hotCafeCollectionView.dataSource = self
        hotCafeCollectionView.delegate = self
        recommendCollectionView.delegate = self
        recommendCollectionView.dataSource = self
    }
    
    private func setUpTableView() {
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
    }
    
    private func initBeforeData() {
        BestReviewService.shareInstance.getBestReview(flag: 0, token: token, completion: { (res) in
            self.bestCafes = res
        }) { (err) in
            print("인기 리뷰 조회 실패 \(err)")
        }
        RecommendHotPlaceService.shareInstance.getCommandHotPlace(token: token, completion: { (res) in
            self.hotPlaces = res
        }) { (err) in
            print("모카 추천 플레이스 조회 실패 \(err)")
        }
    }
    
    // back action
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Tab Action
    @IBAction func tabAction(_ sender: UIButton) {
        selectTabPosition = sender.tag
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
        initSearchData()
    }
}

extension HomeSearchVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let searchResults = searchResults else { return 0 }
        
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let searchResults = searchResults else { return cell }
        
        if let resultCell = tableView.dequeueReusableCell(withIdentifier: "HomeSearchResultCell", for: indexPath) as?  HomeSearchResultCell {
            resultCell.searchResult = searchResults[indexPath.row]
            cell = resultCell
        }
        
        return cell
    }
    
    // delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let bestCafe = searchResults?[indexPath.item] else { return }
        if let vc = UIStoryboard(name: "LocationTab", bundle: nil).instantiateViewController(withIdentifier: "LocationCafeDetailVC") as? LocationCafeDetailVC {
            vc.cafeId = bestCafe.cafeID
            self.navigationController?.pushViewController(vc, animated: true)
        }
        // 카페 이름 검색했을 떄랑 위치 검색했을 때 다른 데로 이동
    }
}

// 검색 전 화면 설정
extension HomeSearchVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recommendCollectionView {
            guard let hotPlaces = hotPlaces else { return 0 }
            return hotPlaces.count
        } else {
            guard let bestCafes = bestCafes else { return 0 }
            return bestCafes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if collectionView == hotCafeCollectionView {
            guard let bestCafe = bestCafes?[indexPath.item] else { return cell }
            if let cafeCell = hotCafeCollectionView.dequeueReusableCell(withReuseIdentifier: "HotCafeCollectionViewCell", for: indexPath) as? HotCafeCollectionViewCell {
                cafeCell.bestCafe = bestCafe
                cell = cafeCell
            }
        } else {
            guard let hotPlace = hotPlaces?[indexPath.item] else { return cell }
            if let placecell = recommendCollectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCollectionViewCell", for: indexPath) as? RecommendCollectionViewCell {
                placecell.recommendHotPlace = hotPlace
                cell = placecell
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
        } else if collectionView == recommendCollectionView {
            guard let hotPlace = hotPlaces?[indexPath.item] else { return }
            if let vc = UIStoryboard(name: "HomeTab", bundle: nil).instantiateViewController(withIdentifier: "HotPlaceVC") as? HotPlaceVC {
                vc.placeId = hotPlace.hotPlaceID
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension HomeSearchVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        beforeSearchView.isHidden = true
        
        return true
    }
}
