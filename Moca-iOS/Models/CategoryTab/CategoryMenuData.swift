//
//  CategoryMenuData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 6..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct CategoryMenuData: Codable {
    let status: Int
    let message: String
    let data: [Menu]
}

struct Menu: Codable {
    let cafeMainMenuID: Int
    let cafeMainMenuName: String
    
    enum CodingKeys: String, CodingKey {
        case cafeMainMenuID = "cafe_main_menu_id"
        case cafeMainMenuName = "cafe_main_menu_name"
    }
}
