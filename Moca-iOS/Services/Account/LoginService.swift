//
//  LoginJoinService.swift
//  Moca-iOS
//
//  Created by 조수민 on 07/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation
import Alamofire

struct LoginService: APIService, RequestService {
    
    static let shareInstance = LoginService()
    let URL = url("/login")
    typealias NetworkData = AccountData
    
    func postLogin(id: String, password: String, completion: @escaping (Token) -> Void, error: @escaping (Int) -> Void) {
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        let body: [String: String] = [
            "user_id" : id,
            "user_password" : password
        ]
        postable(URL, body: body, header: header) { (res) in
            switch res {
            case .success(let AccountData):
                print(AccountData.message)
                completion(AccountData.data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
        
    }
}
