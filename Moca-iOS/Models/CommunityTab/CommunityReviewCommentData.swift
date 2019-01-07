//
//  CommunityCommentData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 8..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct CommunityReviewCommentData: Codable {
    let status: Int
    let message: String
    let data: [ReviewComment]
}

struct ReviewComment: Codable {
    let reviewCommentID: Int
    let userID, reviewCommentContent, reviewCommentDate, time: String
    
    enum CodingKeys: String, CodingKey {
        case reviewCommentID = "review_comment_id"
        case userID = "user_id"
        case reviewCommentContent = "review_comment_content"
        case reviewCommentDate = "review_comment_date"
        case time
    }
}
