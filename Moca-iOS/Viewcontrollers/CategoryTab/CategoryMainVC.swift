//
//  CategoryMainVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 5..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class CategoryMainVC: UIViewController {
    @IBOutlet var categoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setUpTableView() {
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
    }
}

extension CategoryMainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let categoryCell = categoryTableView.dequeueReusableCell(withIdentifier: "CategoryMainCell") as? CategoryMainCell {
            categoryCell.delegate = self
            cell = categoryCell
        }
        return cell
    }
}

extension CategoryMainVC: ListViewCellDelegate {
    func goToViewController(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

