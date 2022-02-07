//
//  ProfileViewModel.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/02.
//

import Foundation
import UIKit


class ProfileViewModel {
    
    
    static let shared = ProfileViewModel()

    
    var iconImageName = ["notice", "faq", "qna", "setting_alarm", "permit"]
    
    var noticeTitle = ["공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정", "이용 약관"]
    
    
    var userInfo: Observable<UserInfo> = Observable(UserInfo(id: "", v: 0, uid: "", phoneNumber: "", email: "", socketid: "", fcMtoken: "", nick: "", birth: "", gender: 0, hobby: "", comment: [], reputation: [0], sesac: 0, sesacCollection: [0], background: 0, backgroundCollection: [0], purchaseToken: [], transactionID: [], reviewedBefore: [], reportedNum: 0, reportedUser: [], dodgepenalty: 0, dodgepenaltyGetAt: "", dodgeNum: 0, dodgeNumGetAt: "", ageMin: 0, ageMax: 0, searchable: 0, createdAt: ""))
    
    var nick = Observable("")
    var ageMin = Observable(18)
    var ageMax = Observable(65)
    var gender = Observable(-1)
    var hobby = Observable("")
    var searchable = Observable(1)
    
    
    
    // status code 분기처리는 나중에
    
    func getUserInfo(completion: @escaping (UserInfo?, Error?, Int?) -> Void) {
        
        APIService.getUserInfo(idToken: UserDefaults.standard.string(forKey: "idToken")!) { userInfo, error, statuscode in
            
            guard let userInfo = userInfo else {
                return
            }
            
            self.userInfo.value = userInfo
            
            completion(userInfo, error, statuscode)
            
        }
    }
    
    
    func updateMyPage(model: UpdateMyPageModel, completion: @escaping (Int?) -> Void) {
        
        APIService.updateMyPage(idToken: UserDefaults.standard.string(forKey: "idToken")!, model: model) { statuscode in
            
            guard let statuscode = statuscode else {
                return
            }

            completion(statuscode)
        }
    }
    
    
    func updateData() {
        searchable.value = userInfo.value.searchable
        ageMin.value = userInfo.value.ageMin
        ageMax.value = userInfo.value.ageMax
        hobby.value = userInfo.value.hobby
        nick.value = userInfo.value.nick
    }
}
