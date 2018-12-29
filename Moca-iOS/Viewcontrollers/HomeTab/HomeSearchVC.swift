//
//  HomeSearchVC.swift
//  Moca-iOS
//
//  Created by 조수민 on 2018. 12. 28..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeSearchVC: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultTableView: UITableView!
//    @IBOutlet var swipeRecognizer: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpTextField()
    }

//    @IBAction func swipeAction(_ sender: Any) {
//        if swipeRecognizer.direction == .right {
//            dismiss(animated: true)
//        }
//
//    }

    private func setUpTextField() {
        // TextField paddingLeft 설정
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: searchTextField.frame.height))
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = UITextField.ViewMode.always
    }
    
    // tableView delegate랑 dataSource 설정
    private func setUpTableView() {
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
    }
    
    // swipe Action
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension HomeSearchVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSearchResultCell", for: indexPath) as! HomeSearchResultCell
        
        
        
        return cell
    }
    
    // delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 카페 이름 검색했을 떄랑 위치 검색했을 때 다른 데로 이동
    }
}
