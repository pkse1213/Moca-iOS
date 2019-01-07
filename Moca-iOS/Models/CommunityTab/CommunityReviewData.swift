//
//  CafeDetailBestReviewData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 7..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct CommunityReviewData: Codable {
    let status: Int
    let message: String
    let data: [CommunityReview]
}

struct CommunityReview: Codable {
    let reviewID, cafeID: Int
    let userID: String
    let image: [ReviewImage]
    let reviewRating: Int
    let reviewTitle, reviewContent, reviewDate, cafeName: String
    let cafeAddress, time: String
    let likeCount, commentCount: Int
    let auth, like: Bool
    
    enum CodingKeys: String, CodingKey {
        case reviewID = "review_id"
        case cafeID = "cafe_id"
        case userID = "user_id"
        case image
        case reviewRating = "review_rating"
        case reviewTitle = "review_title"
        case reviewContent = "review_content"
        case reviewDate = "review_date"
        case cafeName = "cafe_name"
        case cafeAddress = "cafe_address"
        case time
        case likeCount = "like_count"
        case commentCount = "comment_count"
        case auth, like
    }
}

struct ReviewImage: Codable {
    let reviewID: Int
    let reviewImgURL: String
    
    enum CodingKeys: String, CodingKey {
        case reviewID = "review_id"
        case reviewImgURL = "review_img_url"
    }
}
