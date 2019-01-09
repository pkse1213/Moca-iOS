//
//  MocaPicksCafeData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 9..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct MocaPicksData: Codable {
    let status: Int
    let message: String
    let data: [MocaPicks]
}

struct MocaPicks: Codable {
    let cafeID: Int
    let cafeName, cafeIntroduction: String
    let cafeRating: Int
    let latitude, longitude: Double
    let cafeImgMain, nerbySubway: String
    
    enum CodingKeys: String, CodingKey {
        case cafeID = "cafe_id"
        case cafeName = "cafe_name"
        case cafeIntroduction = "cafe_introduction"
        case cafeRating = "cafe_rating"
        case latitude, longitude
        case cafeImgMain = "cafe_img_main"
        case nerbySubway = "nerby_subway"
    }
}
