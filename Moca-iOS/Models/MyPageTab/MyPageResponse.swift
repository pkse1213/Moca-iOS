//
//  MyPageResponse.swift
//  Moca-iOS
//
//  Created by 조수민 on 10/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation
import ObjectMapper

struct MyPageResponse : Codable {
    let status : Int
    let message : String
    let data : MyPageData
}

struct MyPageData : Codable {
    let userID, userName, userPhone: String
    let userImgURL: String
    let userStatusComment: String
    let pushFlag, auth, follow: Bool
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userName = "user_name"
        case userPhone = "user_phone"
        case userImgURL = "user_img_url"
        case userStatusComment = "user_status_comment"
        case pushFlag = "push_flag"
        case auth, follow
    }
}
