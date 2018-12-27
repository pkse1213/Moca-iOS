//
//  MocaPlusDetailVC.swift
//  Moca-iOS
//
//  Created by soomin on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPlusDetailVC: UIViewController {
    
    @IBOutlet weak var mocaPlusDetailTableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }
    
    private func setUpTableView() {
        mocaPlusDetailTableView.dataSource = self
        mocaPlusDetailTableView.delegate = self
    }
}

extension MocaPlusDetailVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MocaPlusDetailTopicCell", for: indexPath) as! MocaPlusDetailTopicCell
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MocaPlusCafeCell", for: indexPath) as! MocaPlusCafeCell
            
            cell.cafeContentsLabel.text = "북한강을 바라보다 어느새 시간이 훌쩍, 복잡하고 어지럽게 움직이는 서울에서 도망치듯 빠져나와 따듯한 커피 한 잔 그리고 담백하고 촉촉한 베이커리까지 즐기며 한 껏 여유를 찾을 수 있던 이 곳. 웅장해 보이던 외관 안에는 오히려, 아늑하고 섬세한 손길이 가득했다. "
            
            // label 간격 조정
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            let attrString = NSMutableAttributedString(string: cell.cafeContentsLabel?.text ?? "")
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
            cell.cafeContentsLabel.attributedText = attrString
            
            return cell
        }
    }
    
}
