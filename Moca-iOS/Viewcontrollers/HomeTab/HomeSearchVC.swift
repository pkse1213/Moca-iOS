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
    
    @IBOutlet var beforeSearchView: UIView!
    @IBOutlet var hotCafeCollectionView: UICollectionView!
    @IBOutlet var recommendCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpTextField()
        setUpHotCafeCollectionView()
        setUpRecommendCollectionView()
        
        searchTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }

    private func setUpTextField() {
        // TextField paddingLeft 설정
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: searchTextField.frame.height))
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = UITextField.ViewMode.always
    }
    
    // 이번주 인기 카페 설정
    private func setUpHotCafeCollectionView() {
        hotCafeCollectionView.dataSource = self
        hotCafeCollectionView.delegate = self
    }
    
    // 모카 추천 플레이스 설정
    private func setUpRecommendCollectionView() {
        recommendCollectionView.delegate = self
        recommendCollectionView.dataSource = self
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
    @IBAction func allTabAction(_ sender: Any) {
        selectTabPosition = 0
        
        // Tab 아래 선택바 부분 색상 변경
        allTabView.backgroundColor = UIColor(red: 225/255, green: 178/255, blue: 163/255, alpha: 1.0)
        cafeTabView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        locationTabView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        // Tab 버튼 글씨 색상 변경
        allTabButton.setTitleColor(#colorLiteral(red: 0.8823529412, green: 0.6980392157, blue: 0.6392156863, alpha: 1), for: .normal)
        cafeTabButton.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
        locationTabButton.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
    }
    
    @IBAction func cafeTabAction(_ sender: Any) {
        selectTabPosition = 1
        
        allTabView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        cafeTabView.backgroundColor = UIColor(red: 225/255, green: 178/255, blue: 163/255, alpha: 1.0)
        locationTabView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        allTabButton.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
        cafeTabButton.setTitleColor(#colorLiteral(red: 0.8823529412, green: 0.6980392157, blue: 0.6392156863, alpha: 1), for: .normal)
        locationTabButton.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
        
        
    }
    
    @IBAction func locationTabAction(_ sender: Any) {
        selectTabPosition = 2
        
        allTabView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        cafeTabView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        locationTabView.backgroundColor = UIColor(red: 225/255, green: 178/255, blue: 163/255, alpha: 1.0)
        
        allTabButton.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
        cafeTabButton.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
        locationTabButton.setTitleColor(#colorLiteral(red: 0.8823529412, green: 0.6980392157, blue: 0.6392156863, alpha: 1), for: .normal)
    }
    
}

extension HomeSearchVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSearchResultCell", for: indexPath) as! HomeSearchResultCell
        
        
        
        return cell
    }
    
    // delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 카페 이름 검색했을 떄랑 위치 검색했을 때 다른 데로 이동
    }
}

// 검색 전 화면 설정
extension HomeSearchVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.hotCafeCollectionView {
            return 8
        }
        else {
            return 7
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.hotCafeCollectionView {
            let cell = hotCafeCollectionView.dequeueReusableCell(withReuseIdentifier: "HotCafeCollectionViewCell", for: indexPath) as! HotCafeCollectionViewCell
            
            return cell
        }
        else {
            let cell = recommendCollectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCollectionViewCell", for: indexPath) as! RecommendCollectionViewCell
            
            return cell
        }
    }
}

extension HomeSearchVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        beforeSearchView.isHidden = true
        
        return true
    }
}
