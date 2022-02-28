//
//  QueueAPIService.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/09.
//

import Foundation
import Alamofire
import SwiftyJSON


class QueueAPIService {
    
    // 성별 필터 버튼을 선택
    static func onQueue(idToken: String, model: OnQueueModel, completion: @escaping (OnQueueResult?, Int?, Error?) -> Void) {
        
        let headers = ["idtoken" : idToken] as HTTPHeaders
        
        let onQueueParameters: Parameters = [
            "region": model.region,
            "lat": model.lat,
            "long": model.long
        ]
        
        AF.request(QueueEndPoint.onqueue.url.absoluteString, method: .post, parameters: onQueueParameters, headers: headers).responseDecodable(of: OnQueueResult.self) { response in
            
            let statusCode = response.response?.statusCode
            
            switch response.result {
                
            case .success(let success):
                print("success: ", success)
                completion(response.value, statusCode, nil)
            case .failure(let error):
                print("error: ", error)
                completion(nil, statusCode, error)
            }
            
        
        }
    
    }
    
    static func postQueue(idToken: String, model: PostQueueModel, completion: @escaping (Int?, Error?) -> Void) {
        
        let headers = ["idtoken" : idToken, "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
        
        let parameters: Parameters = [
            "type": model.type,
            "region": model.region,
            "long": model.long,
            "lat": model.lat,
            "hf": model.hf
        ]
        
        AF.request(QueueEndPoint.postQueue.url.absoluteString, method: .post, parameters: parameters, encoding: URLEncoding(arrayEncoding: .noBrackets), headers: headers).responseString { response in
            
            completion(response.response?.statusCode, response.error)
            
        }
        
    }
        
    static func deleteQueue(idToken: String, completion: @escaping (Int?, Error?) -> Void) {
        
        let headers = ["idtoken" : idToken, "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
        
        AF.request(QueueEndPoint.deleteQueue.url.absoluteString, method: .delete, headers: headers).responseString { response in
            
            print(#function)
            completion(response.response?.statusCode, response.error)
        }
    }
    
    
    // 새싹 찾기 부분
    
    static func hobbyReqeust(idToken: String, otheruid: String, completion: @escaping (Int?, Error?) -> Void) {
        
        let headers = ["idtoken" : idToken, "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders

        let parameters: Parameters = ["otheruid": otheruid]
        
        AF.request(QueueEndPoint.hobbyRequest.url.absoluteString, method: .post, parameters: parameters, headers: headers).responseString { response in
            
            print(#function)
            completion(response.response?.statusCode, response.error)
        }
    }
    
    static func hobbyAccept(idToken: String, otheruid: String, completion: @escaping (Int?, Error?) -> Void) {
        
        let headers = ["idtoken" : idToken, "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
        let parameters: Parameters = ["otheruid": otheruid]
        
        AF.request(QueueEndPoint.hobbyAccept.url.absoluteString, method: .post, parameters: parameters, headers: headers).responseString { response in
            
            print(#function)
            completion(response.response?.statusCode, response.error)
        }
    }
    
}
