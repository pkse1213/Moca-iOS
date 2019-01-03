//
//  NetworkResult.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 2..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case successWithNil(Int)
    case error(Int)
}
