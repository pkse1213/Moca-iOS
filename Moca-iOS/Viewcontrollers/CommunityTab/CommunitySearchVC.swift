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
    
    @IBOutlet var beforeSearchView: UIView!
    @IBOutlet var hotCafeCollectionView: UICollectionView!
    @IBOutlet var popularUserCollectionView: UICollectionView!
    
    
    // 카페명 검색 결과 뷰 설정
    // 인기 리뷰
    @IBOutlet var popularReviewCollection: UICollectionView!
    // 최신 리뷰
    @IBOutlet var recentReviewCollection: UICollectionView!
    var unit : CGFloat = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpTextField()
        setUpHotCafeCollectionView()
        setUpRecommendCollectionView()
        setUpCafeResultView()
        
        searchTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // TextField paddingLeft 설정
    private func setUpTextField() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: searchTextField.frame.height))
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = UITextField.ViewMode.always
    }
    
    // 이번주 인기 카페 설정
    private func setUpHotCafeCollectionView() {
        hotCafeCollectionView.dataSource = self
        hotCafeCollectionView.delegate = self
    }
    
    // 이번주 인기 많은 사용자 설정
    private func setUpRecommendCollectionView() {
        popularUserCollectionView.delegate = self
        popularUserCollectionView.dataSource = self
    }
    
    // tableView delegate랑 dataSource 설정
    private func setUpTableView() {
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
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
    
    // back action
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // Tab Action
    @IBAction func allTabAction(_ sender: Any) {
        selectTabPosition = 0
        
        // Tab 아래 선택바 부분 색상 변경
        allTabView.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.6980392157, blue: 0.6392156863, alpha: 1)
        cafeTabView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        locationTabView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        // Tab 버튼 글씨 색상 변경
        allTabButton.setTitleColor(#colorLiteral(red: 0.8823529412, green: 0.6980392157, blue: 0.6392156863, alpha: 1), for: .normal)
        cafeTabButton.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
        locationTabButton.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
    }
    
    @IBAction func cafeTabAction(_ sender: Any) {
        selectTabPosition = 1
        
        allTabView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cafeTabView.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.6980392157, blue: 0.6392156863, alpha: 1)
        locationTabView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        allTabButton.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
        cafeTabButton.setTitleColor(#colorLiteral(red: 0.8823529412, green: 0.6980392157, blue: 0.6392156863, alpha: 1), for: .normal)
        locationTabButton.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
        
        
    }
    
    @IBAction func locationTabAction(_ sender: Any) {
        selectTabPosition = 2
        
        allTabView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cafeTabView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        locationTabView.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.6980392157, blue: 0.6392156863, alpha: 1)
        
        allTabButton.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
        cafeTabButton.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
        locationTabButton.setTitleColor(#colorLiteral(red: 0.8823529412, green: 0.6980392157, blue: 0.6392156863, alpha: 1), for: .normal)
    }
    
}

// TableView Delegate, DataSource
extension CommunitySearchVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSearchResultCell", for: indexPath) as! HomeSearchResultCell
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommunitySearchPeopleTableViewCell", for: indexPath) as! CommunitySearchPeopleTableViewCell
            
            return cell
        }
        
    }
    
    // delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 카페 이름 검색했을 떄랑 위치 검색했을 때 다른 데로 이동
    }
}

// 검색 전 화면 설정 & 카페명 검색 결과 설정
extension CommunitySearchVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // 최신 리뷰 셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.recentReviewCollection {
            return CGSize(width:120*unit , height: 120*unit)
        }
        else if collectionView == self.hotCafeCollectionView {
            return CGSize(width:140 , height: 200)
        }
        else if collectionView == self.popularUserCollectionView {
            return CGSize(width: 136, height: 173)
        }
        else {
            return CGSize(width: 170, height: 170)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.hotCafeCollectionView {
            return 8
        }
        else if collectionView == self.popularUserCollectionView {
            return 7
        }
        else if collectionView == self.popularReviewCollection {
            return 5
        }
        else {
            return 30
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.hotCafeCollectionView {
            let cell = hotCafeCollectionView.dequeueReusableCell(withReuseIdentifier: "HotCafeCollectionViewCell", for: indexPath) as! HotCafeCollectionViewCell
            
            return cell
        }
        else if collectionView == self.popularUserCollectionView {
            let cell = popularUserCollectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as! PopularCollectionViewCell
            
            return cell
        }
        else if collectionView == self.popularReviewCollection {
            let cell = popularReviewCollection.dequeueReusableCell(withReuseIdentifier: "PopularReviewCollectionViewCell", for: indexPath) as! PopularReviewCollectionViewCell
            
            return cell
        }
        else {
            let cell = recentReviewCollection.dequeueReusableCell(withReuseIdentifier: "RecentReviewCollectionViewCell", for: indexPath) as! RecentReviewCollectionViewCell
            
            return cell
        }
    }
}

extension CommunitySearchVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        beforeSearchView.isHidden = true
        
        return true
    }
}

