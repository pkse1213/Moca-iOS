//
//  LocationMapDialogVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 2..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class LocationMapDialogVC: UIViewController {

    @IBOutlet weak var dialogBackgroundView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var detailLookButton: UIButton!
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var cafeImageView: UIImageView!
    @IBOutlet weak var cafeLocationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpView()
    }
    
    private func setUpView() {
        cafeImageView.applyRadius(radius: cafeImageView.frame.width/2)
        searchButton.applyRadius(radius: 5)
        searchButton.applyBorder(width: 0.5, color: #colorLiteral(red: 0.9088876247, green: 0.7525063157, blue: 0.6986940503, alpha: 1))
        detailLookButton.applyRadius(radius: 5)
        dialogBackgroundView.applyRadius(radius: 5)
    }
    @IBAction func detailLookAction(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "LocationTab", bundle: nil).instantiateViewController(withIdentifier: "LocationCafeDetailVC") as? LocationCafeDetailVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func searchLocationAction(_ sender: Any) {
    
    }
    
}
