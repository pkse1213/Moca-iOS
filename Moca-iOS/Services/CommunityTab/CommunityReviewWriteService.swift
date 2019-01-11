//
//  CommunityReviewWriteService.swift
//  Moca-iOS
//
//  Created by 조수민 on 11/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CommunityReviewWriteService: APIService, RequestService{
    
    static let shareInstance = CommunityReviewWriteService()
    let URL = url("/user")
    typealias NetworkData = ResponseData
    
    func postFollow(cafeId: String, title : String, content : String, rating : Int, image : [Data]?, token: String, completion: @escaping (String) -> Void, error: @escaping (Int) -> Void) {
        
//        MultipartFormData.appendBodyPart(data: data, name: key)
        
        let cafeId = cafeId.data(using: .utf8)
        let title = title.data(using: .utf8)
        let content = content.data(using: .utf8)
//        let rating = rating.
        let image = image
        let convertedValueNumber: NSNumber = NSNumber(value: Int32(rating))
        let ratingData = NSKeyedArchiver.archivedData(withRootObject: convertedValueNumber)
        
        
        if image == nil{
            
        }
        else{
//            Alamofire.upload(multipartFormData : { multipartFormData in
//                
//                var multipartImage = MultipartFormData()
//                
//                
//
//                
//                
//                //멀티파트를 이용해 데이터를 담습니다
//                multipartFormData.append(cafeId!, withName: "cafe_id")
//                multipartFormData.append(title!, withName: "title")
//                multipartFormData.append(content!, withName: "content")
//                multipartFormData.append(ratingData, withName: "rating")
//                if let image = image {
//                    
//                    for i in 0 ..< image.count {
//                        multipartFormData.append(image[i], withName: "", fileName: "image\(i).png", mimeType: "image/png")
//                    }
//                    
////                    image.forEach { imageData in
////                        multipartImage.append(imageData, withName: "imageData", fileName: "image.png", mimeType: "image/png")
////                    }
//                    
//                }
//                
//                
////                multipartFormData.append(image!, withName: "image", fileName: "image.jpg", mimeType: "image/png")
//            },
//                             to: URL,
//                             encodingCompletion: { encodingResult in
//                                
//                                switch encodingResult{
//                                case .success(let upload, _, _):
//                                    upload.responseData { res in
//                                        switch res.result {
//                                        case .success:
//                                            DispatchQueue.main.async(execute: {
//                                                self.view.networkResult(resultData: "", code: "")
//                                            })
//                                        case .failure(let err):
//                                            print("upload Error : \(err)")
//                                            DispatchQueue.main.async(execute: {
//                                                self.view.networkFailed()
//                                            })
//                                        }
//                                    }
//                                case .failure(let err):
//                                    print("network Error : \(err)")
//                                    self.view.networkFailed()
//                                }//switch
//            }
//            )//Alamofire.upload
            
        }
    }
}

