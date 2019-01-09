//
//  MocaPlusContentData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 10..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct MocaPlusContentData: Codable {
    let status: Int
    let message: String
    let data: [MocaPlusContent]
}

struct MocaPlusContent: Codable {
    let plusContentsID, plusSubjectID, cafeID: Int
    let cafeName, addressDistrictName, plusContentsContent: String
    let contentImages: [ContentImage]
    
    enum CodingKeys: String, CodingKey {
        case plusContentsID = "plus_contents_id"
        case plusSubjectID = "plus_subject_id"
        case cafeID = "cafe_id"
        case cafeName = "cafe_name"
        case addressDistrictName = "address_district_name"
        case plusContentsContent = "plus_contents_content"
        case contentImages
    }
}

struct ContentImage: Codable {
    let plusDefaultImgURL, plusTaggingImgURL: String
    
    enum CodingKeys: String, CodingKey {
        case plusDefaultImgURL = "plus_default_img_url"
        case plusTaggingImgURL = "plus_tagging_img_url"
    }
}
