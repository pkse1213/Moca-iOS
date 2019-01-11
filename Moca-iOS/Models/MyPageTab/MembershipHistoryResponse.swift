//
//  MembershipHistoryResponse.swift
//  Moca-iOS
//
//  Created by 조수민 on 10/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation
import ObjectMapper

struct MembershipHistoryResponse : Codable {
    let status : Int
    let message : String
    let data : [MembershipHistoryData]
}

struct MembershipHistoryData : Codable {
    let cafeName : String
    let cafeMenuImgUrl : String?
    let couponCreateDate : String
    
    enum CodingKeys: String, CodingKey {
        case cafeName = "cafe_name"
        case cafeMenuImgUrl = "cafe_menu_img_url"
        case couponCreateDate = "coupon_create_date"
    }
}
