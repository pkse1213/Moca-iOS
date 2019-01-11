//
//  WriteReviewSearchVC.swift
//  Moca-iOS
//
//  Created by 조수민 on 10/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class WriteReviewSearchVC: UIViewController {
    
    @IBOutlet var searchText: UITextField!
    @IBOutlet var searchResultTableView: UITableView!
    @IBOutlet var inputBtn: UIButton!
    
    var parentVC = UIViewController()
    
    var selectIndex = -1
    
    
    var cafeName = "default"
    var cafeLocation = "default"
    
    
    
    var communityReviewSearchResultList: [CommunityReviewSearchResult]? {
        didSet { searchResultTableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        setUpButton()
        
        searchText.setLeftPaddingPoints(37.0)
        searchText.returnKeyType = UIReturnKeyType.done
        searchText.delegate = self
        
//        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // 버튼 radius
    private func setUpButton() {
        inputBtn.layer.masksToBounds = false
        inputBtn.layer.cornerRadius = 5.0
        inputBtn.clipsToBounds = true
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true)
    }

    @objc func endEditing(){
        searchText.resignFirstResponder()
    }
    
    @IBAction func inputAction(_ sender: Any) {
        if let upVC = parentVC as? CommunityReviewWrittingVC {
            upVC.getCafeName = cafeName
            upVC.getCafeLocation = cafeLocation
        }
        
        dismiss(animated: true)
    }
}

extension WriteReviewSearchVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let communityReviewSearchResultList = communityReviewSearchResultList else { return 0 }
        return communityReviewSearchResultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if let searchResultCell = searchResultTableView.dequeueReusableCell(withIdentifier: "ReviewSearchCell", for: indexPath) as? ReviewSearchCell {
            
            if let resultDataList = communityReviewSearchResultList {
                searchResultCell.cafeName.text = resultDataList[indexPath.row].cafeName
                searchResultCell.cafeLocation.text = resultDataList[indexPath.row].cafeAddressDetail
            }
            
            cell = searchResultCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let dataList = communityReviewSearchResultList {
            let countNum = dataList.count

            for i in 0 ..< countNum {
                var iP = IndexPath.init(row: i, section: 0)
                if let tableCell = searchResultTableView.cellForRow(at: iP) as? ReviewSearchCell {
                    tableCell.isSelectedView.isHidden = true
                }
            }
        }

        if let currentcell = self.searchResultTableView.cellForRow(at: indexPath) as? ReviewSearchCell {

            currentcell.isSelectedView.isHidden = false
            
            self.cafeName = currentcell.cafeName.text ?? "default"
            self.cafeLocation = currentcell.cafeLocation.text ?? "default"
        }
    }
}

extension WriteReviewSearchVC : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            if let searchString = textField.text {
                searchText.resignFirstResponder()
                
                CommunityReviewSearchService.shared.getReviewSearchResult(keyword: searchString, completion: { (communityReviewSearchResultList) in
                    self.communityReviewSearchResultList = communityReviewSearchResultList
                    
                    self.searchResultTableView.reloadData()
                }) { (errCode) in
                    print("검색에 실패하였습니다. || \(errCode)")
                }
            }
            
            searchText.resignFirstResponder()
            return false
        }
        return true
    }
}
