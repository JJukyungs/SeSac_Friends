//
//  QueuEndPoint.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/09.
//

import Foundation


enum QueueEndPoint {
    case onqueue
    case postQueue // post
    case deleteQueue
    
    // 새싹 찾기쪽
    case hobbyRequest
    case hobbyAccept
    case myQueueState
}

extension QueueEndPoint {
    var url: URL {
        switch self {
        case .onqueue:
            return .makeEndPoint("queue/onqueue")
        case .postQueue:
            return .makeEndPoint("queue")
        case .deleteQueue:
            return .makeEndPoint("queue")
            
        case .hobbyRequest:
            return .makeEndPoint("queue/hobbyrequest")
        case .hobbyAccept:
            return .makeEndPoint("queue/hobbyaccept")
        case .myQueueState:
            return .makeEndPoint("queue/myQueueState")
        }
    }
}
