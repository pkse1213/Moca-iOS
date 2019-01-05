//
//  CategoryOptionService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 6..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CategoryMenuService: APIService, RequestService {
    
    static let shareInstance = CategoryMenuService()
    let URL = url("/category/menu")
    typealias NetworkData = CategoryMenuData
    
    func getCategoryConcept(completion: @escaping ([Menu]) -> Void, error: @escaping (Int) -> Void) {
        gettable(URL, body: nil, header: nil) { res in
            switch res {
            case .success(let CategoryMenuData):
                let data = CategoryMenuData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
