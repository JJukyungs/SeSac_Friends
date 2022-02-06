//
//  UpdateMyPageModel.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/05.
//

import Foundation


struct UpdateMyPageModel: Encodable {
    let searchable: Int
    let ageMin: Int
    let ageMax: Int
    let gender: Int
    let hobby: String
}
