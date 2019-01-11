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
    let userID, userName: String
    let userImgURL: String
    let reviewCommentContent, reviewCommentDate, time: String
    let auth: Bool
    
    enum CodingKeys: String, CodingKey {
        case reviewCommentID = "review_comment_id"
        case userID = "user_id"
        case userName = "user_name"
        case userImgURL = "user_img_url"
        case reviewCommentContent = "review_comment_content"
        case reviewCommentDate = "review_comment_date"
        case time, auth
    }
}
