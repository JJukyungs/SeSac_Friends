//
//  HomeNearFriendViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/16.
//

import UIKit
import Tabman
import Pageboy


class HomeNearFriendViewController: UIViewController {
    
    let mainView = HomeNearFriendView()
    let viewModel = HomeViewModel.shared
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        /*
        // navigation Button [찾기 중단]
        let stopButton = UIBarButtonItem(title: "찾기중단", style: .done, target: self, action: #selector(stopButtonClicked))
        self.navigationItem.rightBarButtonItem = stopButton
        stopButton.tintColor = .blackColor
        */
        
        mainView.changeHobbyButton.addTarget(self, action: #selector(changeHobbyButtonClicked), for: .touchUpInside)
        mainView.refreshButton.addTarget(self, action: #selector(refreshButtonClicked), for: .touchUpInside)
    }
    
    // MARK: - Action
    /*
    @objc func stopButtonClicked() {
        print(#function)
        
        QueueAPIService.deleteQueue(idToken: UserDefaults.standard.string(forKey: "idToken")!) { statuscode, error in
            
            switch statuscode {
            case HTTPStatusCode.SUCCESS.rawValue:
                print(statuscode)
                
                // 플로팅 버튼 수정
                
                // home 화면으로 이동
                self.navigationController?.popToRootViewController(animated: true)
            
            // case 201, 406, 401  처리 해야함
            case DeleteQueue.ALREADY_MATCHING.rawValue:
                print(statuscode)
                self.view.makeToast("누군가와 취미를 함께하기로 약속하셨어요!")
                // 201 (GET, /queue/myQueueState) 호출 해야함
                
            case HTTPStatusCode.FIREBASE_TOKEN_ERROR.rawValue:
                self.updateIdToken { idToken, error in
                    self.stopButtonClicked()
                }
                
            default:
                print(statuscode)
            }
        }
    }
    */
    
    @objc func changeHobbyButtonClicked() {
        print(#function)
        
        QueueAPIService.deleteQueue(idToken: UserDefaults.standard.string(forKey: "idToken")!) { statuscode, error in
            
            switch statuscode {
            case HTTPStatusCode.SUCCESS.rawValue:
                
                // 취미화면 화면으로 이동
                self.navigationController?.popViewController(animated: true)
            
            // case 201, 406, 401  처리 해야함
            case DeleteQueue.ALREADY_MATCHING.rawValue:
                print(statuscode)
                self.view.makeToast("누군가와 취미를 함께하기로 약속하셨어요!")
                // 201 (GET, /queue/myQueueState) 호출 해야함
                
            case HTTPStatusCode.FIREBASE_TOKEN_ERROR.rawValue:
                self.updateIdToken { idToken, error in
                    self.changeHobbyButtonClicked()
                }
                
            default:
                print(statuscode)
            }
        }
    }
    
    @objc func refreshButtonClicked() {
        print(#function)
        
        let searchModel = OnQueueModel(region: HomeViewModel.shared.centerRegion.value, lat: HomeViewModel.shared.centerLat.value, long: HomeViewModel.shared.centerLong.value)
        
        viewModel.searchFriends(model: searchModel) { OnQueueModel, statuscode, error in
            
            // 페이지에 맞게 불러오기
            // 전에있던거 복 붙 ㄴㄴㄴ
            
        }
        
    }
    
}
