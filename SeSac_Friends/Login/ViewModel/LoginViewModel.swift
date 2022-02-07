//
//  CertificationViewModel.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/23.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    
    static let shared = LoginViewModel()
    
    var phoneNumber = Observable("")
    var nohypenNumber = Observable("")
    var nickname = Observable("")
    var birthday = Observable(Date.now) // Date 값으로 변경
    var email = Observable("")
    var gender = Observable(-1) // 아무것도 선택 안했을 시 2 (21.01.24 변경사항)
    var year = Observable("")
    var month = Observable("")
    var day = Observable("")
    
    
    // 유효성 검사
    var isvalidPhoneNumber = Observable(false)  // 휴대폰 번호 유형에 맞나 확인
    var isvalidNickname = Observable(false)     // 중복된 닉네임인가 확인
    var isValidEmial = Observable(false)        // email 형식에 맞나 확인
    var isValidBirthday = Observable(false)     // 만 18세 이상만 가능해야함
    
    var verificationID = ""
    var verificationCode = ""
    
//    var verificationID = Observable("")
//    var verificationCode = Observable("")
    
    var idToken = ""
    // FCMToken 은 기기별로 다를 수 잇음?
    var FCMToken = UserDefaults.standard.string(forKey: "FCMToken")!
    
    
    
    // phoneNumber 에 하이픈 넣어주기
    func phoneNumberAddHyphen() {
        phoneNumber.value = phoneNumber.value.pretty()
    }
    
    
    // 전화번호 형식에 맞는 지 체크
    func validPhoneNumber(phoneNumber: String?) -> Void {
        
        guard phoneNumber != nil else { return }
        
        let phoneRegex = "^01[0-1]-?([0-9]{3,4})-?([0-9]{4})"
        let pred = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        isvalidPhoneNumber.value = pred.evaluate(with: phoneNumber)
        
    }
    
    
    // 인증번호 전송
    func requestPhoneNumber(completion: @escaping (String?, Error?) -> Void) {
        
        Auth.auth().languageCode = "ko-KR"
        
        PhoneAuthProvider.provider().verifyPhoneNumber("+82 \(nohypenNumber.value)", uiDelegate: nil) { verificationID, error in
            
            guard let error = error else {
                completion(verificationID, nil)
                print("verificationID : ", verificationID!)
//                self.verificationID = verificationID!
                return
            }
            
            completion(nil, error)
        }
    }
    
    // 인증번호 확인
    func checkCertificationCode(completion: @escaping (AuthDataResult?, Error?) -> Void) {

        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)

        Auth.auth().signIn(with: credential) { (authResult, error) in

            if error == nil {
                print("User Signed in...")

                let currentUser = Auth.auth().currentUser

                currentUser?.getIDTokenForcingRefresh(true) { idToken, error in

                    if let error = error {
                        print("error : ", error)
                        completion(authResult, error)
                        return;

                    }
                    
                    if let idToken = idToken {

                        print("idToken: ", idToken)
                        self.idToken = idToken

                        UserDefaults.standard.set(idToken, forKey: "idToken")
                        completion(authResult, nil)
                    }
                }
            } else {
                completion(nil, error)
                print("여기서 에러?")
                print("error :", error.debugDescription)
            }
        }
    }
    
    
    
    
    
    // 인증코드 유효성 검사
    func validCode(code: String?) -> Bool {
        guard code != nil else { return false }

        let codeRegex = "([0-9]{6})"
        let codeTest = NSPredicate(format: "SELF MATCHES %@", codeRegex)

        return codeTest.evaluate(with: code)
    }
    
    
    // 닉네임 유효성 검사  최소 1자리 이상 최대 10자리
    func validNickname(nickname: String) -> Void {
        
        if nickname.count > 0 && nickname.count <= 10 {
            isvalidNickname.value = true
        } else {
            isvalidNickname.value = false
        }
        
    }
    
    // 생년월일 유효성 검사는 VC에서 구현
    
    // 이메일 유효성 검사
    func validEmail(email: String) -> Void {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        isValidEmial.value = emailTest.evaluate(with: email)
    }
    
    
   
    
    // API 연결!!
    
    func getUserInfo(completion: @escaping (UserInfo?, Error?, Int?) -> Void) {
        
        APIService.getUserInfo(idToken: idToken) { userInfo, error, statuscode in
            
            completion(userInfo, error, statuscode)
        }
    }
    
    
    func signUpUserInfo(completion: @escaping (Int?, Error?) -> Void) {
        
        let signUpModel = signUpModel(phoneNumber: "+82 \(nohypenNumber.value)", FCMtoken: FCMToken, nick: nickname.value, email: email.value, birth: birthday.value, gender: gender.value)
        
        
        APIService.signUpUserInfo(idToken: idToken, model: signUpModel) { statuscode, error in
            
            completion(statuscode, error)
        }
    }
    
}

