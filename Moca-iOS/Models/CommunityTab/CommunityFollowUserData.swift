//
//  UserFollowData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 9..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct CommunityFollowUserData: Codable {
    let status: Int
    let message: String
    let data: [FollowUser]
}

struct FollowUser: Codable {
    let userID, userName: String
    let userPhone: String?
    let userImgURL: String
    let userStatusComment: String?
    let auth, follow: Bool
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userName = "user_name"
        case userPhone = "user_phone"
        case userImgURL = "user_img_url"
        case userStatusComment = "user_status_comment"
        case auth, follow
    }
}
