//
//  FeedCellDelegate.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 8..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

protocol ListViewCellDelegate: class {
    
    func didTapButton(onCell: UITableViewCell)
    
    func showActionSheet()
    
    func goToViewController(vc: UIViewController)
    
    func getViewFrameWidth() -> CGFloat
    
}

extension ListViewCellDelegate {
    func didTapButton(onCell: UITableViewCell) { }
    
    func showActionSheet() { }
    
    func goToViewController(vc: UIViewController) { }
    
    func getViewFrameWidth() -> CGFloat { return 0 }
}
