//
//  HotPlaceListData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 10..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct HotPlaceCafeData: Codable {
    let status: Int
    let message: String
    let data: [HotPlaceCafe]
}

struct HotPlaceCafe: Codable {
    let cafeID: Int
    let cafeName, cafeSubway: String
    let cafeRatingAvg: Int
    let evaluatedCafeIs: Bool
    
    enum CodingKeys: String, CodingKey {
        case cafeID = "cafe_id"
        case cafeName = "cafe_name"
        case cafeSubway = "cafe_subway"
        case cafeRatingAvg = "cafe_rating_avg"
        case evaluatedCafeIs = "evaluated_cafe_is"
    }
}
