//
//  CategoryCafeData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 6..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct CategoryCafeData: Codable {
    let status: Int
    let message: String
    let data: [CategoryCafe]
}

struct CategoryCafe: Codable {
    let cafeID: Int
    let cafeName, cafeAddressDetail: String
    let cafeRatingAvg: Int
    let cafeMenuImgURL, cafeMainMenuName, cafeConceptName: String
    
    enum CodingKeys: String, CodingKey {
        case cafeID = "cafe_id"
        case cafeName = "cafe_name"
        case cafeAddressDetail = "cafe_address_detail"
        case cafeRatingAvg = "cafe_rating_avg"
        case cafeMenuImgURL = "cafe_menu_img_url"
        case cafeMainMenuName = "cafe_main_menu_name"
        case cafeConceptName = "cafe_concept_name"
    }
}
