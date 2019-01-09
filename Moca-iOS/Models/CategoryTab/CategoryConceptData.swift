//
//  CategoryConceptData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 6..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct CategoryConceptData: Codable {
    let status: Int
    let message: String
    let data: [CategoryConcept]
}

struct CategoryConcept: Codable {
    let cafeConceptID: Int
    let cafeConceptName: String
    
    enum CodingKeys: String, CodingKey {
        case cafeConceptID = "cafe_concept_id"
        case cafeConceptName = "cafe_concept_name"
    }
}
