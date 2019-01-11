//
//  CommandHotPlaceData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 10..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct RecommendHotPlaceData: Codable {
    let status: Int
    let message: String
    let data: [RecommendHotPlace]
}

struct RecommendHotPlace: Codable {
    let hotPlaceID: Int
    let hotPlaceName: String
    let hotPlaceImg: String
    
    enum CodingKeys: String, CodingKey {
        case hotPlaceID = "hot_place_id"
        case hotPlaceName = "hot_place_name"
        case hotPlaceImg = "hot_place_img"
    }
}
