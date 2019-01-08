//
//  CafeDetailNearCafeData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 6..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct NearByCafeData: Codable {
    let status: Int
    let message: String
    let data: [NearByCafe]
}

struct NearByCafe: Codable {
    let cafeID: Int
    let cafeLatitude, cafeLongitude: Double
    let cafeName, cafeImgURL, addressDistrictName: String
    let cafeRatingAvg: Int
    let distance: String
    
    enum CodingKeys: String, CodingKey {
        case cafeID = "cafe_id"
        case cafeLatitude = "cafe_latitude"
        case cafeLongitude = "cafe_longitude"
        case cafeName = "cafe_name"
        case cafeImgURL = "cafe_img_url"
        case addressDistrictName = "address_district_name"
        case cafeRatingAvg = "cafe_rating_avg"
        case distance
    }
}
