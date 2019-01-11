//
//  CommunityReviewSearchResponse.swift
//  Moca-iOS
//
//  Created by 조수민 on 10/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation

struct CommunityReviewSearchData: Codable {
    let status: Int
    let message: String
    let data: [CommunityReviewSearchResult]
}

struct CommunityReviewSearchResult: Codable {
    let cafeId : Int
    let cafeName : String
    let cafeImgUrl : String?
    let cafeAddressDetail : String
    let type : Bool
    
    enum CodingKeys: String, CodingKey {
        case cafeId = "cafe_id"
        case cafeName = "cafe_name"
        case cafeImgUrl = "cafe_img_url"
        case cafeAddressDetail = "cafe_address_detail"
        case type = "type"
    }
}
