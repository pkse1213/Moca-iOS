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
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic2VldW5pIiwiaXNzIjoiRG9JVFNPUFQifQ.56TYkh--ZSO7duJvdVLf-BOgFBPCG9fdDRGUGTmtC68"
    var evaluateDetail: MocaPicksEvaluateDetail? {
        didSet { baristaDetailTableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        initData()
        setupNaviBar()
    }
    
    private func setupNaviBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NanumGothicBold", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.black]
//        self.navigationItem.title = "Moca Picks"
        let button: UIButton = UIButton()
        button.setImage(#imageLiteral(resourceName: "commonBackBlack"), for: .normal)
        button.addTarget(self, action: #selector(backAction(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func backAction(_: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
            baristaCell.totalLabel.applyLineSpacing(lineSpacing: 7, text: evaluateDetail.evaluationSummary)
            print(evaluateDetail.baristaImgURL)
            print("\n\n\n\n")
            baristaCell.profileImageView.imageFromUrl(evaluateDetail.baristaImgURL, defaultImgPath: "commonDefaultimage")
                cell = baristaCell
        }
        return cell
    }
    
}
