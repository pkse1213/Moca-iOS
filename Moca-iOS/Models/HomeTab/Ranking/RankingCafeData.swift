//
//  RankingCafeData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 9..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct RankingCafeData: Codable {
    let status: Int
    let message: String
    let data: [RankingCafe]
}

struct RankingCafe: Codable {
    let cafeID: Int
    let cafeName: String
    let cafeMenuImgURL: String?
    let addressDistrictName: String
    let cafeRatingAvg: Int
    let evaluatedCafeIs: Bool
    
    enum CodingKeys: String, CodingKey {
        case cafeID = "cafe_id"
        case cafeName = "cafe_name"
        case cafeMenuImgURL = "cafe_menu_img_url"
        case addressDistrictName = "address_district_name"
        case cafeRatingAvg = "cafe_rating_avg"
        case evaluatedCafeIs = "evaluated_cafe_is"
    }
}
