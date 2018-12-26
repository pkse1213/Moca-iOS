//
//  RankingCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeRankingCell: UITableViewCell {

    @IBOutlet weak var rankTableView: UITableView!
    @IBOutlet weak var moreBtnImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTableView()
    }

    private func setUpTableView() {
        rankTableView.delegate = self
        rankTableView.dataSource = self
    }
    
}

extension HomeRankingCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rankTableView.dequeueReusableCell(withIdentifier: "HomeRankingListCell") as! HomeRankingListCell
        return cell
    }
    
}
