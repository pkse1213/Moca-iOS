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
    
    private func setUpTableView() {
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
    }
    @IBAction func applyAction(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "CategoryTab", bundle: nil).instantiateViewController(withIdentifier: "CategoryResultVC") as? CategoryResultVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CategoryMainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let categoryCell = categoryTableView.dequeueReusableCell(withIdentifier: "CategoryMainCell") as? CategoryMainCell {
            cell = categoryCell
        }
        return cell
    }
}
