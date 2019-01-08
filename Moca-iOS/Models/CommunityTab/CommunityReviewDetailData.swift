//
//  CommunityReviewDetailData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 8..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct CommunityReviewDetailData: Codable {
    let status: Int
    let message: String
    let data: CommunityReview
}
