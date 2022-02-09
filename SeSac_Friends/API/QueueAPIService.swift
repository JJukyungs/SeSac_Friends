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
}
