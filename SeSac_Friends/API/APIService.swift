//
//  APIService.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/24.
//

import Foundation
import Alamofire
import SwiftyJSON


class APIService {
    
    static func getUserInfo(idToken: String, completion: @escaping (UserInfo?, Error?, Int?) -> Void) {
        
        let headers = ["idtoken" : idToken] as HTTPHeaders
        
        AF.request(EndPoint.getMyUserInfo.url.absoluteString, method: .get, headers: headers).responseDecodable(of: UserInfo.self) { response in
            
            let statusCode = response.response?.statusCode
            
            switch response.result {
                
            case .success(let success):
                print("success : ", success)
                completion(response.value, nil, statusCode )
            case .failure(let error):
                print("error", error)
                completion(nil, error, statusCode)
            }
        }
        .responseString { response in
            print("responseString : ", response)
        }
    }
    
    
    
    static func signUpUserInfo(idToken: String, model: signUpModel, completion: @escaping (Int?, Error?) -> Void ) {
        
        let headers = ["idtoken" : idToken, "Content-Type" : "application/x-www-form-urlencoded"] as HTTPHeaders
        
        
        let signUpParameters: Parameters = [
            "phoneNumber" : model.phoneNumber,
            "FCMtoken" : model.FCMtoken,
            "nick" : model.nick,
            "email" : model.email,
            "birth" : model.birth,
            "gender" : model.gender
        ]
        
        AF.request(EndPoint.postMyUserInfo.url.absoluteString, method: .post, parameters: signUpParameters, headers: headers).responseString { response in
            
            completion(response.response?.statusCode, nil)
            
        }
        
        
    }
    
    // 회원탈퇴 기능은 일단 인썸니아로 직접 하는 중
    
    static func withdrawSignUp(idToken: String, completion: @escaping (Int?, Error?) -> Void) {
        
        let headers = ["idtoken": idToken, "Content-Type" : "application/x-www-form-urlencoded "] as HTTPHeaders
        
        
        AF.request(EndPoint.withdrawSignUp.url.absoluteString, method: .post, headers: headers).responseString { response in
            
            completion(response.response?.statusCode, nil)
        }
    }
    
    
    // myPage update
    
    static func updateMyPage(idToken: String, model: UpdateMyPageModel, completion: @escaping (Int?)-> Void) {
        
        let headers = ["idtoken": idToken, "Content-Type" : "application/x-www-form-urlencoded "] as HTTPHeaders
        
        let updateParameter: Parameters = [
            "searchable" : model.searchable,
            "ageMin" : model.ageMin,
            "ageMax" : model.ageMax,
            "gender" : model.gender,
            "hobby" : model.hobby
        ]
        
        AF.request(EndPoint.updateMyPage.url.absoluteString, method: .post, parameters: updateParameter, headers: headers).responseString { response in
            
            completion(response.response?.statusCode)
        }
    }
    
}
