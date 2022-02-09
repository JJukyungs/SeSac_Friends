//
//  OnQueueResult.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/09.
//

import Foundation



// MARK: - OnQueueResult
struct OnQueueResult: Codable {
    let fromQueueDB, fromQueueDBRequested: [FromQueueDB]
    let fromRecommend: [String]
}

// MARK: - FromQueueDB
struct FromQueueDB: Codable {
    let uid, nick: String
    let lat, long: Double
    let reputation: [Int]
    let hf, reviews: [String]
    let gender, type, sesac, background: Int
}
