//
//  EndPoint.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/24.
//

import Foundation


enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum EndPoint {
    case getMyUserInfo
    case postMyUserInfo
    case withdrawSignUp // 회원탈퇴
    case updateMyPage
}


extension URL {
    static let baseURL = "http://test.monocoding.com:35484/"
    
    static func makeEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
    }
}

extension EndPoint {
    
    var url: URL {
        switch self {
        case .getMyUserInfo:
            return .makeEndPoint("user")
        case .postMyUserInfo:
            return .makeEndPoint("user")
        case .withdrawSignUp:
            return .makeEndPoint("user/withdraw")
        case .updateMyPage:
            return .makeEndPoint("update/mypage")
        }
    }
}
