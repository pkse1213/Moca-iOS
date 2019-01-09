//
//  RankingCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeRankingCell: UITableViewCell {
    var rankingCafes: [RankingCafe]?
    weak var delegate: ListViewCellDelegate?
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
            delegate?.goToViewController(vc: vc)
        }
    }
    
}

extension HomeRankingCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rankingCafes = rankingCafes else { return 0 }
        return rankingCafes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let cafe = rankingCafes?[indexPath.row] else { return cell }
        if let rankingCell = rankTableView.dequeueReusableCell(withIdentifier: "HomeRankingListCell") as? HomeRankingListCell {
            rankingCell.rankNumLabel.text = "\(indexPath.row+1)"
            rankingCell.cafe = cafe
            cell = rankingCell
        }
        return cell
    }
    
}
