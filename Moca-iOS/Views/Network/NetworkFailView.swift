//
//  NetworkFailView.swift
//  Moca-iOS
//
//  Created by 박세은 on 24/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

protocol NetworkFailDelegate {
    func retryAction()
}

class NetworkFailView: UIView {
    @IBOutlet var retryButton: UIButton!
    var delegate: NetworkFailDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        retryButton.applyRadius(radius: 10)
    }
    
    
    class func instanceFromXib() -> UIView {
        return UINib(nibName: "NetworkFailView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView
    }
    
    @IBAction func retryAction(_ sender: UIButton) {
        delegate?.retryAction()
    }
    
}
