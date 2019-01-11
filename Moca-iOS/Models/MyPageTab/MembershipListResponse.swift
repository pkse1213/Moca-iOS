//
//  MembershipListResponse.swift
//  Moca-iOS
//
//  Created by 조수민 on 10/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation
import ObjectMapper

struct MembershipListResponse : Codable {
    let status : Int
    let message : String
    let data : [MembershipData]
}

struct MembershipData : Codable {
    let cafeId : Int
    let cafeName : String
    let membershipCreateDate : String
    let cafeImgUrl : String?
    
    enum CodingKeys: String, CodingKey {
        case cafeId = "cafe_id"
        case cafeName = "cafe_name"
        case membershipCreateDate = "membership_create_date"
        case cafeImgUrl = "cafe_img_url"
    }
}
