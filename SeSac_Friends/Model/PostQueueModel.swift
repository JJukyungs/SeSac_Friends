//
//  APIModel.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/15.
//

import Foundation


struct PostQueueModel: Encodable {
    let type: Int
    let region: Int
    let lat: Double
    let long: Double
    let hf: [String]
}
