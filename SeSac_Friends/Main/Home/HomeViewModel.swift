//
//  HomeViewModel.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/09.
//

import Foundation


class HomeViewModel {
    
    static let shared = HomeViewModel()
    
    
    // 전체선택은 2 여자 0 남자 1 선택 안된건 -1
    var genderFilter = Observable(2)
}
