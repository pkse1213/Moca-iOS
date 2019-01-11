//
//  MocaPicksEvaluateData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 11..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
struct MocaPicksEvaluateData: Codable {
    let status: Int
    let message: String
    let data: [MocaPicksEvaluate]
}

struct MocaPicksEvaluate: Codable {
    let baristaID: Int
    let baristaName, baristaTitle: String
    let baristaImgURL: String
    let evaluationBeanCondition: Int
    let evaluationBeanConditionComment: String
    let evaluationRoasting: Int
    let evaluationRoastingComment: String
    let evaluationCreativity: Int
    let evaluationCreativityComment: String
    let evaluationReasonable: Int
    let evaluationReasonableComment: String
    let evaluationConsistancy: Int
    let evaluationConsistancyComment: String
    
    enum CodingKeys: String, CodingKey {
        case baristaID = "barista_id"
        case baristaName = "barista_name"
        case baristaTitle = "barista_title"
        case baristaImgURL = "barista_img_url"
        case evaluationBeanCondition = "evaluation_bean_condition"
        case evaluationBeanConditionComment = "evaluation_bean_condition_comment"
        case evaluationRoasting = "evaluation_roasting"
        case evaluationRoastingComment = "evaluation_roasting_comment"
        case evaluationCreativity = "evaluation_creativity"
        case evaluationCreativityComment = "evaluation_creativity_comment"
        case evaluationReasonable = "evaluation_reasonable"
        case evaluationReasonableComment = "evaluation_reasonable_comment"
        case evaluationConsistancy = "evaluation_consistancy"
        case evaluationConsistancyComment = "evaluation_consistancy_comment"
    }
}
