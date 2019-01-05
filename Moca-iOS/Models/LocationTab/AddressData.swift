//
//  AddressData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 2..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct AddressData: Codable {
    let documents: [Address]
}

struct Address: Codable {
    let placeName, addressName, roadAddressName, x: String
    let y: String
    
    enum CodingKeys: String, CodingKey {
        case placeName = "place_name"
        case addressName = "address_name"
        case roadAddressName = "road_address_name"
        case x, y
    }
}
