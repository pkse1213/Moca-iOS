//
//  RankingCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeRankingCell: UITableViewCell {
    var navigationController: UINavigationController?
    @IBOutlet weak var rankTableView: UITableView!
    @IBOutlet weak var moreBtnImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTableView()
        registerGesture()
    }

    private func setUpTableView() {
        rankTableView.delegate = self
        rankTableView.dataSource = self
    }
    
    private func registerGesture() {
        let moreBtnTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(moreAction(_:)))
        moreBtnImageView.addGestureRecognizer(moreBtnTapGestureRecognizer)
    }
    
    @objc func moreAction(_:UIImageView) {
        if let vc = UIStoryboard(name: "HomeTab", bundle: nil).instantiateViewController(withIdentifier: "HomeRankingListVC") as? HomeRankingListVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension HomeRankingCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let rankingCell = rankTableView.dequeueReusableCell(withIdentifier: "HomeRankingListCell") as? HomeRankingListCell {
            cell = rankingCell
        }
        return cell
    }
    
}
