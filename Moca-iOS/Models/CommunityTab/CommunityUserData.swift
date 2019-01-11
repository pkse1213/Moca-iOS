//
//  CommunityUserData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 8..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct CommunityUserData: Codable {
    let status: Int
    let message: String
    let data: CommunityUser
}

struct CommunityUser: Codable {
    let userID, userName: String
    let userImgURL: String
    let userStatusComment: String?
    let reviewCount, followerCount, followingCount: Int
    let auth, follow: Bool
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userName = "user_name"
        case userImgURL = "user_img_url"
        case userStatusComment = "user_status_comment"
        case reviewCount = "review_count"
        case followerCount = "follower_count"
        case followingCount = "following_count"
        case auth, follow
    }
}
