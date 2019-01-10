//
//  CommunitySearchResultData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 10..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct CommunitySearchResultData: Codable {
    let status: Int
    let message: String
    let data: CommunitySearchResult
}

struct CommunitySearchResult: Codable {
    var popularReviewList, reviewListOrderByLatest: [SearchReview]
    var searchUserList: [SearchUser]
}

struct SearchReview: Codable {
    let reviewID: Int
    let reviewImgURL: String?
    
    enum CodingKeys: String, CodingKey {
        case reviewID = "review_id"
        case reviewImgURL = "review_img_url"
    }
}

struct SearchUser: Codable {
    let userID, userName: String
    let userStatusComment: String?
    let userImgURL: String
    let followIs: Bool
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userName = "user_name"
        case userStatusComment = "user_status_comment"
        case userImgURL = "user_img_url"
        case followIs = "follow_is"
    }
}
