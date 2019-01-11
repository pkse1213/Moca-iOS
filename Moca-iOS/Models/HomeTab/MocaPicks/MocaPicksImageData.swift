//
//  MocaPicksImageData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 11..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct MocaPicksImageData: Codable {
    let status: Int
    let message: String
    let data: [MocaPicksImage]
}

struct MocaPicksImage: Codable {
    let evaluatedCafeImgURL: String?
    let evaluatedCafeMainImg: Bool
    
    enum CodingKeys: String, CodingKey {
        case evaluatedCafeImgURL = "evaluated_cafe_img_url"
        case evaluatedCafeMainImg = "evaluated_cafe_main_img"
    }
}
