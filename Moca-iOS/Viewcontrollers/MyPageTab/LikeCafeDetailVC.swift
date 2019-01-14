//
//  LikeCafeDetailVC.swift
//  Moca-iOS
//
//  Created by 조수민 on 02/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class LikeCafeDetailVC: UIViewController {
    
    
    @IBOutlet var likeCafeListTableView: UITableView!
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic2VldW5pIiwiaXNzIjoiRG9JVFNPUFQifQ.56TYkh--ZSO7duJvdVLf-BOgFBPCG9fdDRGUGTmtC68"
    var dataList : [ScrapCafeData]? {
        didSet { likeCafeListTableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getLikeCafeData()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setUpTableView() {
        likeCafeListTableView.delegate = self
        likeCafeListTableView.dataSource = self
    }
    
    // 통신
    private func getLikeCafeData() {
        MyPageScrapService.shared.getScrap(token: token, completion: { (scrapDataList) in
            self.dataList = scrapDataList
        }) { (errCode) in
            print("스크랩 카페 조회 실패 || \(errCode)")
        }
    }
}

extension LikeCafeDetailVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataList = dataList else { return 1 }
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = likeCafeListTableView.dequeueReusableCell(withIdentifier: "LikeCafeDetailTableViewCell", for: indexPath) as! LikeCafeDetailTableViewCell
        
        var image = dataList?[indexPath.row].cafeImgURL
//        let imageUrl = image?[0].cafeImgUrl
        
//        cell.cafeBackImageView.imageFromUrl(imageUrl, defaultImgPath: "")
        cell.cafeNameLabel.text = dataList?[indexPath.row].cafeName
        cell.cafeLocationLabel.text = dataList?[indexPath.row].cafeAddressDetail
        
        
        
        return cell
    }
}
