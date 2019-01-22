//
//  AccountData.swift
//  Moca-iOS
//
//  Created by 조수민 on 07/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation

struct AccountData : Codable {
    let status: Int
    let message: String
    let data: Token
}

struct Token : Codable {
    let token: String
}
