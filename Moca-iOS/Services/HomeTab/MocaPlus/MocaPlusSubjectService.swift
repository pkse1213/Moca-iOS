//
//  MocaPlusSubjectService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 9..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct MocaPlusSubjectService: APIService, RequestService {
    
    static let shareInstance = MocaPlusSubjectService()
    let URL = url("/plus")
    typealias NetworkData = MocaPlusSubjectData
    
    func getMocaPlusSubject(length: Int, token: String, completion: @escaping ([MocaPlusSubject]) -> Void, error: @escaping (Int) -> Void) {
        let rankingURL = URL + "/\(length)"
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(rankingURL, body: nil, header: header) { res in
            switch res {
            case .success(let MocaPlusSubjectData):
                print(MocaPlusSubjectData.message)
                let data = MocaPlusSubjectData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
