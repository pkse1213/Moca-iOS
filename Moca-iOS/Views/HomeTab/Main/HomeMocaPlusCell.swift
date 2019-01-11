//
//  HomeMocaPlusCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 9..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class HomeMocaPlusCell: UITableViewCell {
    @IBOutlet weak var moreBtnImageView: UIImageView!
    @IBOutlet weak var mocaPlusTableView: UITableView!
    
    var mocaPlusSubject: [MocaPlusSubject]?
    weak var delegate: ListViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTableView()
        registerGesture()
    }

    private func registerGesture() {
        let moreBtnTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(moreAction(_:)))
        moreBtnImageView.addGestureRecognizer(moreBtnTapGestureRecognizer)
    }
    
    private func setUpTableView() {
        mocaPlusTableView.delegate = self
        mocaPlusTableView.dataSource = self
    }
    
    @objc func moreAction(_:UIImageView) {
        if let vc = UIStoryboard(name: "MocaPlus", bundle: nil).instantiateViewController(withIdentifier: "MocaPlusHomeVC") as? MocaPlusHomeVC {
            delegate?.goToViewController(vc: vc)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension HomeMocaPlusCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mocaPlusSubject = mocaPlusSubject else { return 0 }
        return mocaPlusSubject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let mocaPlus = mocaPlusSubject?[indexPath.row] else { return cell }
        
        if let mocaPlusCell = mocaPlusTableView.dequeueReusableCell(withIdentifier: "HomeMocaPlusListCell") as? HomeMocaPlusListCell {
            mocaPlusCell.mocaPlus = mocaPlus
            cell = mocaPlusCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let mocaPlusSubject = mocaPlusSubject?[indexPath.row] else { return }
        if let vc = UIStoryboard(name: "MocaPlus", bundle: nil).instantiateViewController(withIdentifier: "MocaPlusDetailVC") as? MocaPlusDetailVC {
            vc.mocaPlusSubject = mocaPlusSubject
            delegate?.goToViewController(vc: vc)
        }
    }
}
