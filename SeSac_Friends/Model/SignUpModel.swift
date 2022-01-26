//
//  SignUpModel.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/26.
//

import Foundation


struct signUpModel: Encodable {
    let phoneNumber, FCMtoken, nick, email: String
    let birth : Date
    let gender: Int
}
