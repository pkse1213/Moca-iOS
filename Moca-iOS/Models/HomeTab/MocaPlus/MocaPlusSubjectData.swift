//
//  MocaPlusSubjectData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 9..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct MocaPlusSubjectData: Codable {
    let status: Int
    let message: String
    let data: [MocaPlusSubject]
}

struct MocaPlusSubject: Codable {
    let plusSubjectID: Int
    let editorID, editorName: String
    let editorImgURL: String
    let plusSubjectTitle: String
    let plusSubjectImgURL: String
    
    enum CodingKeys: String, CodingKey {
        case plusSubjectID = "plus_subject_id"
        case editorID = "editor_id"
        case editorName = "editor_name"
        case editorImgURL = "editor_img_url"
        case plusSubjectTitle = "plus_subject_title"
        case plusSubjectImgURL = "plus_subject_img_url"
    }
}
