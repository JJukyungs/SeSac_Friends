//
//  MyQueueStateResult.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/03/02.
//

import Foundation


struct MyQueueStateResult: Codable {
    var dodged: Int
    var matched: Int
    var reviewed: Int
    var matchedNick: String?
    var matchedUid: String?
}
