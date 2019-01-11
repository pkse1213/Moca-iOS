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
    let cafeName: String
    let evaluatedCafeRating: Int
    let addressDistrictName: String
    let evaluatedCafeImgURL: String?
    let scrabIs: Bool
    
    enum CodingKeys: String, CodingKey {
        case cafeID = "cafe_id"
        case cafeName = "cafe_name"
        case evaluatedCafeRating = "evaluated_cafe_rating"
        case addressDistrictName = "address_district_name"
        case evaluatedCafeImgURL = "evaluated_cafe_img_url"
        case scrabIs = "scrab_is"
    }
}
