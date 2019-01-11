//
//  CouponDataResponse.swift
//  Moca-iOS
//
//  Created by 조수민 on 10/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation
import ObjectMapper

struct CouponDataResponse : Codable {
    let status : Int
    let message : String
    let data : [CouponData]
}

struct CouponData : Codable {
    let couponId : Int
    let couponAuthenticationNumber : String
    
    enum CodingKeys: String, CodingKey {
        case couponId = "coupon_id"
        case couponAuthenticationNumber = "coupon_authentication_number"
    }
}
