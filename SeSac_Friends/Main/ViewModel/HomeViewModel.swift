//
//  HomeViewModel.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/09.
//

import Foundation


enum floationgStatus: Int {
    case defaultStatus = 0
    case matchingStatus = 1
    case matchedStatus = 2
}


// final error  -> Swift Lint

// print 찍으면 욕먹음!! -> 나중에 앱에서도 리소스, 메모리를 잡아먹음
// print 찍는걸 막는 라이브러리 있음.

// 테크 블로그 -> lint 쓰자 . 무조건!!

// R.swift

// identifier 은닉화

// 나중에라는 게 기술부채 느낌!!!!

// PropertyWrapper .. enum

// 프로젝트 세팅



final class HomeViewModel {
    
    static let shared = HomeViewModel()
    
    var userInfo: Observable<UserInfo> = Observable(UserInfo(id: "", v: 0, uid: "", phoneNumber: "", email: "", socketid: "", fcMtoken: "", nick: "", birth: "", gender: 0, hobby: "", comment: [], reputation: [0], sesac: 0, sesacCollection: [0], background: 0, backgroundCollection: [0], purchaseToken: [], transactionID: [], reviewedBefore: [], reportedNum: 0, reportedUser: [], dodgepenalty: 0, dodgepenaltyGetAt: "", dodgeNum: 0, dodgeNumGetAt: "", ageMin: 0, ageMax: 0, searchable: 0, createdAt: ""))
    
    var onQueueResult: Observable<OnQueueResult> = Observable(OnQueueResult(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
    
    // 전체선택은 2 여자 0 남자 1 선택 안된건 -1
    var genderFilter = Observable(2)
    
    // 위치 위도 경도 Region -> 화면이 움직일때마다 값을 넣어주고 불러와야함 [위도 경도: Double, Region: Int]
    var centerLat = Observable(0.0) // +90 후 소수점 제거-> 5자리
    var centerLong = Observable(0.0) // + 180 후 소수점 제거 -> 5자리
    var centerRegion = Observable(0) // lat + long 10자리
    
    
    
    
    
    // 저장되는 어노테이션 값
    var manAnnotation: [CustomAnnotation] = []
    var womanAnnotation: [CustomAnnotation] = []
    
    // 취미 입력 값
    // 서비스에서 추천하는 취미 배열
    var fromRecommendHobby: Observable<[String]> = Observable([])
    
    var nearByFriendsHobby: Observable<[String]> = Observable([])
    
    var hobbyArray: [String] = []
    
    var myHobbyArray: Observable<[String]> = Observable([])
    
    
    // 플로팅 버튼 상태 초기화면 0 취미 1 찾는 중 2
    var floatingStatus: Observable<Int> = Observable(0)
    
    
    // 성별, 취미로 필터링된 주변 새싹 정보
    // 새싹에서 2로 고정해놧다.. 이걸 못봣네
    var fillterResultDB: [FromQueueDB] = []

    
    // myQueueSate 값
    
    var myQueueState = Observable(MyQueueStateResult(dodged: 0, matched: 0, reviewed: 0, matchedNick: "", matchedUid: ""))
    
    
    
    
    // MARK: - API
    
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
    
    // 주변 새싹 친구 찾기
    func searchFriends(model: OnQueueModel, completion: @escaping (OnQueueResult?, Int?, Error?) -> Void) {
        
        QueueAPIService.onQueue(idToken: UserDefaults.standard.string(forKey: "idToken") ?? "", model: model) { onqueueresult, statuscode, error in
            
            
            guard let onqueueresult = onqueueresult else {
                return
            }
            
            self.onQueueResult.value = onqueueresult
            
            completion(onqueueresult, statuscode, error)
        }
    }
    
    // 새싹 친구 찾기 [취미화면에서]
    
    func postQueue(model: PostQueueModel, completion: @escaping (Int?, Error?) -> Void) {
        
        QueueAPIService.postQueue(idToken: UserDefaults.standard.string(forKey: "idToken") ?? "", model: model) { statuscode, error in
            
            guard let statuscode = statuscode else {
                return
            }

            completion(statuscode, error)
        }
    }
    
    
    // 새싹 찾기 -> 요청, 수락
    
    func hobbyRequest(otheruid: String, completion: @escaping (Int?, Error?) -> Void) {
        
        QueueAPIService.postHobbyRequest(idToken: UserDefaults.standard.string(forKey: "idToken") ?? "", otheruid: otheruid) { statuscode, error in
            
            guard let statuscode = statuscode else {
                return
            }
            completion(statuscode, error)
        }
    }
    
    func hobbyAccept(otheruid: String, completion: @escaping (Int?, Error?) -> Void) {
        
        QueueAPIService.postHobbyAccept(idToken: UserDefaults.standard.string(forKey: "idToken") ?? "", otheruid: otheruid) { statuscode, error in
            
            guard let statuscode = statuscode else {
                return
            }

            completion(statuscode, error)
        }
    }
    
    func myQueueState(completion: @escaping (MyQueueStateResult?, Int?, Error?) -> Void) {
        
        QueueAPIService.getMyQueueState(idToken: UserDefaults.standard.string(forKey: "idToken") ?? "") { myQueuestate, statuscode, error in
            
            guard let myQueuestate = myQueuestate else {
                completion(nil, statuscode, error)
                return
            }
            self.myQueueState.value = myQueuestate
            
            completion(myQueuestate, statuscode, error)

        }
    }
    
    
    
    // MARK: - 함수
    
    // 새싹 이미지 분기 처리
    
    func setupSesacFaceImageType(sesac: Int) -> sesacFaceImageType {
        
        switch sesac {
            
        case 0:
            return .face1
        case 1:
            return .face2
        case 2:
            return .face3
        case 3:
            return .face4
        case 4:
            return .face5
        default:
            return .face1
        }
    }
    
    // Region
    
    func setRegion(lat: Double, long: Double) {
        
        centerLat.value = lat
        centerLong.value = long
        // lat : 90 Login: 180 5글자
        var changeLat = String(lat+90)
        var changeLong = String(long+180)
        
        changeLat = changeLat.components(separatedBy: ["."]).joined()
        
        changeLong = changeLong.components(separatedBy: ["."]).joined()
        
        let resultRegion = changeLat.substring(from: 0, to: 4) + changeLong.substring(from: 0, to: 4)
        
        centerRegion.value = Int(resultRegion) ?? 0
        
        
    }
    
    // 호출 장소. 취미창 찾기 버튼 클릭시, 중단시,
    func checkFloatingStatus(status: Int) {
        //상태 저장을 위해 UserDefualt에 저장
        let floatingStatus = UserDefaults.standard.integer(forKey: "floatingStatus")
        
        self.floatingStatus.value = floatingStatus
    }
    
    
    
    
}
