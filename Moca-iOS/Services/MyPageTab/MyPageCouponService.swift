//
//  MyPageCouponService.swift
//  Moca-iOS
//
//  Created by 조수민 on 10/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation
import Alamofire

struct MyPageCouponService : APIService, RequestService {
    
    typealias NetworkData = CouponDataResponse
    static let shared = MyPageCouponService()
    let couponListUrl = url("/coupon")
    
    // 쿠폰 리스트 조회
    func getCouponList(token : String, completion : @escaping([CouponData]) -> Void, error : @escaping(Int) -> Void) {
        
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        
        gettable(couponListUrl, body: nil, header: header) { (res) in
            switch res {
            case .success(let CouponDataResponse):
                let data = CouponDataResponse.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}
