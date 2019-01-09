//
//  CafeDetailImageData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 6..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct CafeDetailImageData: Codable {
    let status: Int
    let message: String
    let data: [CafeDetailImage]
}

struct CafeDetailImage: Codable {
    let cafeImgURL: String
    
    enum CodingKeys: String, CodingKey {
        case cafeImgURL = "cafe_img_url"
    }
}
