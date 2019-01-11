//
//  SavingHistoryVC.swift
//  Moca-iOS
//
//  Created by 조수민 on 06/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class SavingHistoryVC: UIViewController {

    @IBOutlet var savingHistoryTable: UITableView!
    
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    
    var membershipHistoryList : [MembershipHistoryData]? {
        didSet { savingHistoryTable.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getHistoryList()
        
        savingHistoryTable.delegate = self
        savingHistoryTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func getHistoryList() {
        MembershipHistoryService.shared.getMembershipHistory(token: token, completion: { (membershipList) in
            self.membershipHistoryList = membershipList
        }) { (errCode) in
            print("사용 내역 조회 실패 || \(errCode)")
        }
    }
}

extension SavingHistoryVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let membershipHistoryList = membershipHistoryList else {
            return 1
        }
        return membershipHistoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if (indexPath.row % 12 == 0) {
            if let headerCell = savingHistoryTable.dequeueReusableCell(withIdentifier: "SavingHistoryHeaderTableViewCell", for: indexPath) as? SavingHistoryHeaderTableViewCell {
                
                if let list = membershipHistoryList {
                    headerCell.historyImage.imageFromUrl(list[indexPath.row].cafeMenuImgUrl, defaultImgPath: "")
                    headerCell.cafeName.text = list[indexPath.row].cafeName
                    
//                    let dateString : String = list[indexPath.row].couponCreateDate
//
//                    let dateFormatter = DateFormatter()
//
//                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
//
//                    let date : Date = dateFormatter.date(from: dateString)!
//
//
//                    let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
//                    let currentYearInt = (calendar?.component(NSCalendar.Unit.year, from: date))!
//                    let currentMonthInt = (calendar?.component(NSCalendar.Unit.month, from: date))!
//                    let currentDayInt = (calendar?.component(NSCalendar.Unit.day, from: date))!
                    
                    headerCell.savingDate.text = list[indexPath.row].couponCreateDate
                }
                
                
                
                cell = headerCell
            }
        }
        else if (indexPath.row % 12 == 11) {
            if let footerCell = savingHistoryTable.dequeueReusableCell(withIdentifier: "SavingHistoryFooterTableViewCell", for: indexPath) as? SavingHistoryFooterTableViewCell {
                
                if let list = membershipHistoryList {
                    footerCell.historyImage.imageFromUrl(list[indexPath.row].cafeMenuImgUrl, defaultImgPath: "")
                    footerCell.cafeName.text = list[indexPath.row].cafeName
                    footerCell.savingDate.text = list[indexPath.row].couponCreateDate
                }
                
                cell = footerCell
            }
        }
        else {
            if let centerCell = savingHistoryTable.dequeueReusableCell(withIdentifier: "SavingHistoryTableViewCell", for: indexPath) as? SavingHistoryTableViewCell {
                
                if let list = membershipHistoryList {
                    centerCell.historyImage.imageFromUrl(list[indexPath.row].cafeMenuImgUrl, defaultImgPath: "")
                    centerCell.cafeName.text = list[indexPath.row].cafeName
                    centerCell.savingDate.text = list[indexPath.row].couponCreateDate
                }
                
                cell = centerCell
            }
        }
        
        
        
        return cell
    }
    
    
}
