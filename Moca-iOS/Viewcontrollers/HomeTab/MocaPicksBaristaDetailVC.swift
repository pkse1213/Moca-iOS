//
//  MocaPicksDetailVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 28..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPicksBaristaDetailVC: UIViewController {

    @IBOutlet weak var baristaDetailTableView: UITableView!
    var baristaId = 0
    var cafeId = 0
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    var evaluateDetail: MocaPicksEvaluateDetail? {
        didSet { baristaDetailTableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        initData()
    }
    
    private func initData() {
        MocaPicksEvaluateDetailService.shareInstance.getMocaPicksEvaluateDeatil(cafeId: cafeId, baristaId: baristaId, token: token, completion: { (res) in
            self.evaluateDetail = res
        }) { (err) in
            print("모카픽스 바리스타 디테일 실패 \(err)")
        }
    }
    
    private func setUpTableView() {
        baristaDetailTableView.delegate = self
        baristaDetailTableView.dataSource = self
    }
}

extension MocaPicksBaristaDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let evaluateDetail = evaluateDetail else { return cell }
        if let baristaCell = baristaDetailTableView.dequeueReusableCell(withIdentifier: "MocaPicksBaristaDetailCell") as? MocaPicksBaristaDetailCell {
            baristaCell.baristaNameLabel.text = evaluateDetail.baristaName
            baristaCell.evaluationNameLabel.text = evaluateDetail.baristaTitle
            let evaluationScore = Double(evaluateDetail.evaluationRoasting + evaluateDetail.evaluationBeanCondition + evaluateDetail.evaluationConsistancy + evaluateDetail.evaluationCreativity + evaluateDetail.evaluationReasonable) / 5.0
            baristaCell.evaluationScoreLabel.text = "\(evaluationScore)"
            baristaCell.coffebeanLabel.applyLineSpacing(lineSpacing: 5, text: evaluateDetail.evaluationBeanConditionComment)
            
            baristaCell.roastingLabel.applyLineSpacing(lineSpacing: 5, text: evaluateDetail.evaluationRoastingComment)
            baristaCell.newLabel.applyLineSpacing(lineSpacing: 5, text: evaluateDetail.evaluationCreativityComment)
            baristaCell.priceLabel.applyLineSpacing(lineSpacing: 5, text: evaluateDetail.evaluationReasonableComment)
            baristaCell.tasteLabel.applyLineSpacing(lineSpacing: 5, text: evaluateDetail.evaluationConsistancyComment)
            baristaCell.totalLabel.applyLineSpacing(lineSpacing: 7, text: "evaluateDetail.evaluationSummaryevaluateDetail.evaluationSummaryevaluateDetail.evaluationSummaryevaluateDetail.evaluationSummaryevaluateDetail.evaluationSummaryevaluateDetail.evaluationSummaryevaluateDetail.evaluationSummaryevaluateDetail.evaluationSummaryevaluateDetail.evaluationSummaryevaluateDetail.evaluationSummary")
                cell = baristaCell
        }
        return cell
    }
    
}
