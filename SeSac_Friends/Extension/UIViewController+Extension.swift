//
//  UIViewController+Extension.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/10.
//

import UIKit
import Network
import Toast_Swift



extension UIViewController {
    
    // 갓경후님께서 추가 하라고 알려준 네트워크 모니터
    func monitorNetwork(){
            
            let monitor = NWPathMonitor()
            
            monitor.pathUpdateHandler = {
                path in
                if path.status == .satisfied {
                    DispatchQueue.main.async {
                        return
                    }
                } else {
                    DispatchQueue.main.async {
                        
                        self.view.makeToast("네트워크 연결 상태를 확인하세요")
                    }
                }
            }
            let queue = DispatchQueue(label: "Network")
            monitor.start(queue: queue)
        }
}
