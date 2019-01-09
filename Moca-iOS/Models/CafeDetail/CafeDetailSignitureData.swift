//
//  CafeDetailSignitureData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 6..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct CafeDetailSignitureData: Codable {
    let status: Int
    let message: String
    let data: [CafeDetailSigniture]
}

struct CafeDetailSigniture: Codable {
    let cafeSignitureMenu, cafeSigniturePrice, cafeSignitureImg: String
    
    enum CodingKeys: String, CodingKey {
        case cafeSignitureMenu = "cafe_signiture_menu"
        case cafeSigniturePrice = "cafe_signiture_price"
        case cafeSignitureImg = "cafe_signiture_img"
    }
}
