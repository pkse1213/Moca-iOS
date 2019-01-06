//
//  CafeDetailInfoData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 6..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct CafeDetailInfoData: Codable {
    let status: Int
    let message: String
    let data: CafeDetailInfo
}

struct CafeDetailInfo: Codable {
    let cafeID: Int
    let cafeName: String
    let cafeLatitude, cafeLongitude: Double
    let cafePhone, cafeMenuImgURL, addressDistrictName, cafeAddressDetail: String
    let cafeRatingAvg: Int
    let cafeTimes, cafeDays: String
    let cafeOptionParking, cafeOptionWifi, cafeOptionAllnight, cafeOptionReservation: Bool
    let cafeOptionSmokingarea: Bool
    
    enum CodingKeys: String, CodingKey {
        case cafeID = "cafe_id"
        case cafeName = "cafe_name"
        case cafeLatitude = "cafe_latitude"
        case cafeLongitude = "cafe_longitude"
        case cafePhone = "cafe_phone"
        case cafeMenuImgURL = "cafe_menu_img_url"
        case addressDistrictName = "address_district_name"
        case cafeAddressDetail = "cafe_address_detail"
        case cafeRatingAvg = "cafe_rating_avg"
        case cafeTimes = "cafe_times"
        case cafeDays = "cafe_days"
        case cafeOptionParking = "cafe_option_parking"
        case cafeOptionWifi = "cafe_option_wifi"
        case cafeOptionAllnight = "cafe_option_allnight"
        case cafeOptionReservation = "cafe_option_reservation"
        case cafeOptionSmokingarea = "cafe_option_smokingarea"
    }
}
