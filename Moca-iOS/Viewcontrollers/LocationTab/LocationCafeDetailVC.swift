//
//  LocationCafeDetailView.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 2..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class LocationCafeDetailVC: UIViewController {

    @IBOutlet weak var cafeDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setUpTableView() {
        cafeDetailTableView.delegate = self
        cafeDetailTableView.dataSource = self
    }
    
    @objc func reviewLookActin(_:UIButton) {
        print("dfsd")
        cafeDetailTableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }

}

extension LocationCafeDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 5
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                if let imageCell = cafeDetailTableView.dequeueReusableCell(withIdentifier: "CafeDetailImageListCell") as? CafeDetailImageListCell {
                    cell = imageCell
                }
            case 1:
                if let infoCell = cafeDetailTableView.dequeueReusableCell(withIdentifier: "CafeDetailInfoCell") as? CafeDetailInfoCell {
                    infoCell.reviewLookButton.addTarget(self, action: #selector(reviewLookActin(_:)), for: .touchUpInside)
                    cell = infoCell
                }
            default:
                return cell
            }
        case 1:
            switch indexPath.row {
            case 0:
                if let imageCell = cafeDetailTableView.dequeueReusableCell(withIdentifier: "CafeDetailReviewHeaderCell") as? CafeDetailReviewHeaderCell {
                    cell = imageCell
                }
            case 4:
                if let imageCell = cafeDetailTableView.dequeueReusableCell(withIdentifier: "CafeDetailReviewFooterCell") as? CafeDetailReviewFooterCell {
                    cell = imageCell
                }
            default:
                if let imageCell = cafeDetailTableView.dequeueReusableCell(withIdentifier: "CommunityFeedCell") as? CommunityFeedCell {
                    imageCell.navigationController = self.navigationController
                    cell = imageCell
                }
            }
        case 2:
            if let imageCell = cafeDetailTableView.dequeueReusableCell(withIdentifier: "CafeDetailNearCafeCell") as? CafeDetailNearCafeCell {
                cell = imageCell
            }
        default:
            return cell
        }
        
        return cell
        
    }
    
    
}
