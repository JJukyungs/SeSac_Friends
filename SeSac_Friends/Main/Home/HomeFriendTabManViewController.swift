//
//  HomeFriendTabManViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/17.
//

import UIKit
import SnapKit
import Tabman
import Pageboy

class HomeFriendTabManViewController: TabmanViewController {
    
    
    
    
    var viewControllers: Array<UIViewController> = []
    
    let homeNearFriendsViewController = HomeNearFriendViewController()
    let homeAcceptViewController = HomeAcceptViewController()
    
  
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "새싹 찾기"
        
    
        // navigation Button [찾기 중단]
        let stopButton = UIBarButtonItem(title: "찾기중단", style: .done, target: self, action: #selector(stopButtonClicked))
        self.navigationItem.rightBarButtonItem = stopButton
        stopButton.tintColor = .blackColor
        
        setupTapMan()

    }
    
    
    func setupTapMan() {
        
        print(#function)
        
        
        [homeNearFriendsViewController, homeAcceptViewController].forEach { viewcontroller in
            viewControllers.append(viewcontroller)
        }
        
        self.dataSource = self
        
        let bar = TMBarView<TMConstrainedHorizontalBarLayout, TMLabelBarButton, TMLineBarIndicator>()
        
        addBar(bar, dataSource: self, at: .top)
        
        bar.backgroundView.style = .clear
        bar.layout.transitionStyle = .snap
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        bar.indicator.tintColor = UIColor.greenColor
        
        bar.buttons.customize { button in
            button.selectedTintColor = UIColor.greenColor
            button.tintColor = UIColor.gray6Color
        }

        
    }
    
    
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
}

extension HomeFriendTabManViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        
        switch index {
        case 0:
            return TMBarItem(title: "주변 새싹")
        case 1:
            return TMBarItem(title: "받은 요청")
        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }
    }
    
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        

        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        
        return nil

    }
    
    
}
