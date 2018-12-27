//
//  MocaPlusHomeVC.swift
//  Moca-iOS
//
//  Created by soomin on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPlusHomeVC: UIViewController {
    
    @IBOutlet weak var mocaPlusTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mocaPlusTableView.dataSource = self
        mocaPlusTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
}

extension MocaPlusHomeVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MocaPlusHomeListCell", for: indexPath) as! MocaPlusHomeListCell
        
        // cell 데이터 설정
//        cell.titleLabel.text = "크리스마스, 여기면 충분할 거에요!"
//        cell.nameLabel.text = "김정환"
//        cell.contentsImageView.imageFromUrl("", defaultImgPath: "")
//        cell.profileImageView.imageFromUrl("", defaultImgPath: "")
        
    cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.height/2
        cell.profileImageView.clipsToBounds = true
        
        return cell
    }
    
    // delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 상세보기 띄우기
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "MocaPlusDetailVC") as! MocaPlusDetailVC
    navigationController?.pushViewController(nextVC, animated: true)
    }
}
