//
//  HomeViewModel.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/09.
//

import Foundation


class HomeViewModel {
    
    static let shared = HomeViewModel()
    
    var userInfo: Observable<UserInfo> = Observable(UserInfo(id: "", v: 0, uid: "", phoneNumber: "", email: "", socketid: "", fcMtoken: "", nick: "", birth: "", gender: 0, hobby: "", comment: [], reputation: [0], sesac: 0, sesacCollection: [0], background: 0, backgroundCollection: [0], purchaseToken: [], transactionID: [], reviewedBefore: [], reportedNum: 0, reportedUser: [], dodgepenalty: 0, dodgepenaltyGetAt: "", dodgeNum: 0, dodgeNumGetAt: "", ageMin: 0, ageMax: 0, searchable: 0, createdAt: ""))
    
    var onQueueResult: Observable<OnQueueResult> = Observable(OnQueueResult(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
    
    // 전체선택은 2 여자 0 남자 1 선택 안된건 -1
    var genderFilter = Observable(2)
    
    
    // 저장되는 어노테이션 값
    var manAnnotation: [CustomAnnotation] = []
    var womanAnotation: [CustomAnnotation] = []
    
    
    // main 화면으로 바로 들어가질때도 호출 될수 있게 
    func getUserInfo(completion: @escaping (UserInfo?, Error?, Int?) -> Void) {
        
        UserAPIService.getUserInfo(idToken: UserDefaults.standard.string(forKey: "idToken")!) { userInfo, error, statuscode in
            
            guard let userInfo = userInfo else {
                return
            }
            
            self.userInfo.value = userInfo
            
            completion(userInfo, error, statuscode)
            
        }
    }
    
    
    func searchFriends(model: OnQueueModel, completion: @escaping (OnQueueResult?, Int?, Error?) -> Void) {
        
        QueueAPIService.onQueue(idToken: UserDefaults.standard.string(forKey: "idtoken")!, model: model) { onqueueresult, statuscode, error in
            
            
            guard let onqueueresult = onqueueresult else {
                return
            }
            
            self.onQueueResult.value = onqueueresult
            
            completion(onqueueresult, statuscode, error)
        }
    }
}
