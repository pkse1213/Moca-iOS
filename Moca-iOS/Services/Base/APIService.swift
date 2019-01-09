//
//  APIService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 2..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

protocol APIService {
}

extension APIService {
    static func url(_ path: String) -> String {
        return "http://52.79.173.137:8080" + path
    }
}
