//
//  MocaPicksCafeVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPicksCafeVC: UIViewController {
    @IBOutlet weak var baristaTableView: UITableView!
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic2VldW5pIiwiaXNzIjoiRG9JVFNPUFQifQ.56TYkh--ZSO7duJvdVLf-BOgFBPCG9fdDRGUGTmtC68"
    var cafeInfo: MocaPicks? 
    var cafeImages: [MocaPicksImage]? {
        didSet { baristaTableView.reloadData() }
    }
    var cafeDetail: MocaPicksDetail? {
        didSet { baristaTableView.reloadData() }
    }
    var cafeEvaluate: [MocaPicksEvaluate]? {
        didSet { baristaTableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpListView()
        initData()
        setupNaviBar()
    }
    
    private func setupNaviBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NanumGothicBold", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.title = "Moca Picks"
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
    
    private func setUpListView() {
        baristaTableView.delegate = self
        baristaTableView.dataSource = self
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func initData() {
        guard let cafeInfo = cafeInfo else { return }
       print(cafeInfo.cafeID)
        MocaPicksDetailService.shareInstance.getMocaPicksCafeDetail(cafeId: cafeInfo.cafeID, token: token, completion: { (res) in
            self.cafeDetail = res
//            self.navigationItem.title = res.cafeName
        }) { (err) in
            print("모카픽스 디테일 실패 \(err)")
        }
        MocaPicksImageService.shareInstance.getMocaPicksImage(cafeId: cafeInfo.cafeID, token: token, completion: { (res) in
            self.cafeImages = res
        }) { (err) in
            print("모카픽스 이미지 실패 \(err)")
        }
        MocaPicksEvaluateService.shareInstance.getMocaPicksEvaluate(cafeId: cafeInfo.cafeID, token: token, completion: { (res) in
            self.cafeEvaluate = res
        }) { (err) in
            print("모카픽스 평가 실패 \(err)")
        }
    }
    
}

extension MocaPicksCafeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = cafeDetail, let _ = cafeImages, let cafeEvaluate = cafeEvaluate else { return 0 }
        if section == 2 {
            return cafeEvaluate.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let cafeInfo = cafeInfo, let cafeDetail = cafeDetail, let cafeImages = cafeImages, let cafeEvaluate = cafeEvaluate else { return cell }
        if indexPath.section == 0 {
            if let imageCell = baristaTableView.dequeueReusableCell(withIdentifier: "MocaPicksImageCell") as? MocaPicksImageCell {
                imageCell.cafeId = cafeInfo.cafeID
                imageCell.cafeImages = cafeImages
                imageCell.cafeNameLabel.text = cafeDetail.cafeName
                imageCell.isScrap = cafeInfo.scrabIs
                imageCell.cafeAddressLabel.text = cafeInfo.addressDistrictName
                cell = imageCell
            }
        } else if indexPath.section == 1 {
            if let headerCell = baristaTableView.dequeueReusableCell(withIdentifier: "BaristaHeaderCell") {
                cell = headerCell
            }
        } else if indexPath.section == 2 {
            if let baristaCell = baristaTableView.dequeueReusableCell(withIdentifier: "MocaPicksBaristaCell") as? MocaPicksBaristaCell {
                baristaCell.cafeName = cafeInfo.cafeName
                baristaCell.cafeId = cafeInfo.cafeID
                baristaCell.barista = cafeEvaluate[indexPath.row]
                baristaCell.delegate = self
                cell = baristaCell
            }
        } else if indexPath.section == 3 {
            if let evaluationCell = baristaTableView.dequeueReusableCell(withIdentifier: "MocaPicksEvaluationCell") as? MocaPicksEvaluationCell {
                cell = evaluationCell
            }
        } else if indexPath.section == 4 {
            if let allEvaluationCell = baristaTableView.dequeueReusableCell(withIdentifier: "MocaPicksAllEvaluationCell") as? MocaPicksAllEvaluationCell {
                let evaluation = cafeDetail.evaluatedCafeTotalEvaluation
                allEvaluationCell.evalutionLabel.applyLineSpacing(lineSpacing: 7, text: evaluation)
                cell = allEvaluationCell
            }
        }
        return cell
    }
    
}

extension MocaPicksCafeVC: ListViewCellDelegate {
    func goToViewController(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

