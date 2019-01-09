//
//  CategoryConceptService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 6..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CategoryConceptService: APIService, RequestService {
    
    static let shareInstance = CategoryConceptService()
    let URL = url("/category/concept")
    typealias NetworkData = CategoryConceptData
    
    func getCategoryConcept(completion: @escaping ([CategoryConcept]) -> Void, error: @escaping (Int) -> Void) {
        gettable(URL, body: nil, header: nil) { res in
            switch res {
            case .success(let CategoryConceptData):
                print(CategoryConceptData.message)
                let data = CategoryConceptData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
