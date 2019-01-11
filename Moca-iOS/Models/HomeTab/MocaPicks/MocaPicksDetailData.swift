//
//  MocaPicksDetailData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 9..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct MocaPicksDetailData: Codable {
    let status: Int
    let message: String
    let data: MocaPicksDetail
}

struct MocaPicksDetail: Codable {
    let cafeName, cafeAddressDetail, evaluatedCafeTotalEvaluation, evaluatedCafeRating: String
    
    enum CodingKeys: String, CodingKey {
        case cafeName = "cafe_name"
        case cafeAddressDetail = "cafe_address_detail"
        case evaluatedCafeTotalEvaluation = "evaluated_cafe_total_evaluation"
        case evaluatedCafeRating = "evaluated_cafe_rating"
    }
}
