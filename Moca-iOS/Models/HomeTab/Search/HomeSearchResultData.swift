//
//  HomeSearchResultData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 10..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct HomeSearchResultData: Codable {
    let status: Int
    let message: String
    let data: [HomeSearchResult]
}

struct HomeSearchResult: Codable {
    let cafeID: Int
    let cafeName: String
    let cafeImgURL: String?
    let cafeAddressDetail: String
    let type: Bool
    
    enum CodingKeys: String, CodingKey {
        case cafeID = "cafe_id"
        case cafeName = "cafe_name"
        case cafeImgURL = "cafe_img_url"
        case cafeAddressDetail = "cafe_address_detail"
        case type
    }
}
