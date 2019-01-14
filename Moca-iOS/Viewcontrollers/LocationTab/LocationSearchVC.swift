//
//  LocationSearchVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 2..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class LocationSearchVC: UIViewController {
    var searchAddress: [Address] = [] {
        didSet {
            searchTableView.reloadData()
        }
    }
    @IBOutlet var searchBarView: UIView!
    @IBOutlet var searchBarTxtFd: UITextField!
    @IBOutlet var searchTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarTxtFd.becomeFirstResponder()
        setupView()
        setupNaviBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    private func setupNaviBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NanumGothicBold", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        //        self.navigationItem.title = "Ranking"
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
    
    private func setupView() {
        searchBarTxtFd.delegate = self
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchBarView.applyRadius(radius: 37/2)
        searchBarTxtFd.addTarget(self, action: #selector(search(_:)), for: .editingChanged)
    }
    
    @objc func search(_ sender: UITextField) {
        if let searchText = sender.text {
            if searchText == "" {
                searchAddress = []
            }
            KakaoAddressService.shareInstance.searchAddressWithKeyword(query: searchText, completion: { data in
                self.searchAddress = data
                self.searchTableView.reloadData()
            }) { (errCode) in
                self.simpleAlert(title: "네트워크 오류", message: "서버가 응답하지 않습니다.")
            }
        }
    }
}

extension LocationSearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "LocationSearchCell", for: indexPath) as! LocationSearchCell
        
        cell.addressLabel.text = searchAddress[indexPath.row].placeName
        cell.roadAddressLabel.text = searchAddress[indexPath.row].roadAddressName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        NotificationCenter.default.post(name: Notification.Name("setAddress"), object: searchAddress[indexPath.row])
        self.navigationController?.popViewController(animated: true)
        
    }
}

extension LocationSearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
