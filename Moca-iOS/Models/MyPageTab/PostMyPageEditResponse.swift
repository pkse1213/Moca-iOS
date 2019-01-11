//
//  PostMyPageEditResponse.swift
//  Moca-iOS
//
//  Created by 조수민 on 10/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation
import ObjectMapper

struct PostMyPageEditResponse : Codable {
    let status : Int
    let message : String
    let data : MyPageEditData
}

struct MyPageEditData : Codable {
    let userId : String
    let userName : String
    let userPhone : String
    let userImgUrl : String?
    let userStatusComment : String?
    let auth : Bool
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case userName = "user_name"
        case userPhone = "user_phone"
        case userImgUrl = "user_img_url"
        case userStatusComment = "user_status_comment"
        case auth = "auth"
    }
}
