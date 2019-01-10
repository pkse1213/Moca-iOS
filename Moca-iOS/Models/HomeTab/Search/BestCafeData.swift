//
//  BestReviewData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 10..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct BestCafeData: Codable {
    let status: Int
    let message: String
    let data: [BestCafe]
}

struct BestCafe: Codable {
    let cafeID: Int
    let cafeName: String
    let cafeImgURL: String
    let scrapCount, reviewCount: Int
    
    enum CodingKeys: String, CodingKey {
        case cafeID = "cafe_id"
        case cafeName = "cafe_name"
        case cafeImgURL = "cafe_img_url"
        case scrapCount = "scrap_count"
        case reviewCount = "review_count"
    }
}
