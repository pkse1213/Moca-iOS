//
//  HTTPStatusCode.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 2..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

enum HTTPStatusCode: Int {
    
    case OK = 200
    case Accepted = 204
    case BadRequest = 400
    case Unauthorized = 401
    case Forbidden = 403
    case NotFound = 404
    case Conflict = 409
    case ValidationError = 422
    case DecodingError = 423
    case InternalServerError = 500
}
