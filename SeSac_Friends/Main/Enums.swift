//
//  Enums.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/16.
//

import Foundation


// 한번에 다 하기엔 좀... 일단 지금부터라도 하나씩 추가하고 추후에 전부 추가해 리팩토링 예정


// 메인통신 상태처리
enum HTTPStatusCode: Int {
    case SUCCESS = 200
    case FIREBASE_TOKEN_ERROR = 401
    case UNSUBSCRIBED_USER = 406
    case SERVER_ERROR = 500
    case CLIENT_ERROR = 501
}


// 취미 입력 후 친구 찾기 부분
enum QueueSatusCode: Int {
    case ALREADY_THREE_REPORT = 201
    case FIRST_PENALTY = 203
    case SECOND_PENALTY = 204
    case THIRD_PENALTY = 205
    case GENDER_NOT_SET = 206
}


enum DeleteQueue: Int {
    case ALREADY_MATCHING = 201
    
}


