//
//  QueuEndPoint.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/09.
//

import Foundation


enum QueueEndPoint {
    case onqueue
    case queue // post
}

extension QueueEndPoint {
    var url: URL {
        switch self {
        case .onqueue:
            return .makeEndPoint("queue/onqueue")
        case .queue:
            return .makeEndPoint("")
        }
    }
}
