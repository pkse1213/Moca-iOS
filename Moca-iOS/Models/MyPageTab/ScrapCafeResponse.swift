//
//  ScrapCafeData.swift
//  Moca-iOS
//
//  Created by 조수민 on 09/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation
import ObjectMapper

struct ScrapCafeResponse : Codable {
    let status : Int
    let message : String
    let data : [ScrapCafeData]
}

struct ScrapCafeData : Codable {
    let cafeID: Int
    let cafeName, addressDistrictName: String
    let cafeAddressDetail: String?
    let cafeRatingAvg: Int
    let cafeImgURL: [ScrapCafeImg]
    
    enum CodingKeys: String, CodingKey {
        case cafeID = "cafe_id"
        case cafeName = "cafe_name"
        case addressDistrictName = "address_district_name"
        case cafeAddressDetail = "cafe_address_detail"
        case cafeRatingAvg = "cafe_rating_avg"
        case cafeImgURL = "cafe_img_url"
    }
}

struct ScrapCafeImg : Codable {
    let cafeImgUrl : String?
    
    enum CodingKeys: String, CodingKey {
        case cafeImgUrl = "cafe_img_url"
    }
}
