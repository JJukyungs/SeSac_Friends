//
//  GenderViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/24.
//

import UIKit
import Toast_Swift
import FirebaseAuth


// 마지막 페이지라 이부분에서 회원가입 데이터를 전송을 해줘야함


class GenderViewController: UIViewController {
    
    let mainView = GenderView()
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        mainView.manView.isUserInteractionEnabled = true
        mainView.womanView.isUserInteractionEnabled = true
        
        
       
        mainView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
        mainView.manView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapManImageView(_:))))
        mainView.womanView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapWomanImageView(_:))))
        
        LoginViewModel.shared.gender.bind { number in
            if number != -1{
                if number != 1 {
                    self.mainView.manView.setupGenderType(type: .check)
                    self.mainView.womanView.setupGenderType(type: .notcheck)
                    self.mainView.nextButton.setupBtType(type: .fill)
                } else {
                    self.mainView.womanView.setupGenderType(type: .check)
                    self.mainView.manView.setupGenderType(type: .notcheck)
                    self.mainView.nextButton.setupBtType(type: .fill)
                }
            } else {
                self.mainView.manView.setupGenderType(type: .notcheck)
                self.mainView.womanView.setupGenderType(type: .notcheck)
                self.mainView.nextButton.setupBtType(type: .fill)
            }
        }
    }
    
    
    @objc func nextButtonClicked() {
        
        if LoginViewModel.shared.gender.value != -1 {
            print("회원가입 기능 완성")
        }
        
        
        LoginViewModel.shared.signUpUserInfo { statuscode, error in
            
            switch statuscode {
                
            case 200:
                print("회원가입 성공")
                self.view.makeToast("회원가입에 성공했습니다. \n홈화면으로 전송!")
                
                let vc = MainTabBarController()
                
                DispatchQueue.main.async {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: vc)
                    windowScene.windows.first?.makeKeyAndVisible()
                }
                
                
            case 201:
                print("이미 가입한 유저입니다.")
                self.view.makeToast("이미 가입한 유저입니다.")
                
            case 202:
                print("사용할 수 없는 닉네임입니다.")
                self.view.makeToast("사용할 수 없는 닉네임입니다. /n닉네임을 다시 설정해주세요.")
                self.backNavgationControllerUsed()
                self.view.makeToast("사용할 수 없는 닉네임입니다. /n닉네임을 다시 설정해주세요.")
            case 401:
                print("토큰갱신 에러")
                self.view.makeToast("오류 시 앱을 다시 실행해보세요!")
                
                
                
                
            default:
                print("응 오류야~")
                self.view.makeToast("응 오류야~")
            }
        }
    }
    
    // 네비게이션 여러번 pop
    
    func backNavgationControllerUsed() {
        let viewControllers : [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        
        self.navigationController?.popToViewController(viewControllers[viewControllers.count - 4], animated: false)
    }
    
    @objc func tapManImageView(_ sender: UITapGestureRecognizer) {
        
        
        if LoginViewModel.shared.gender.value != 1 {
            LoginViewModel.shared.gender.value = 1
            mainView.manView.setupGenderType(type: .check)
            mainView.womanView.setupGenderType(type: .notcheck)
//            mainView.nextButton.setupBtType(type: .fill)
        } else {
            LoginViewModel.shared.gender.value = -1
            mainView.manView.setupGenderType(type: .notcheck)
//            mainView.nextButton.setupBtType(type: .disable)
        }
        
        
    }
    
    
    @objc func tapWomanImageView(_ sender: UITapGestureRecognizer) {
        
        if LoginViewModel.shared.gender.value != 0 {
            LoginViewModel.shared.gender.value = 0
            mainView.manView.setupGenderType(type: .notcheck)
            mainView.womanView.setupGenderType(type: .check)
//            mainView.nextButton.setupBtType(type: .fill)
        } else {
            LoginViewModel.shared.gender.value = -1
            mainView.womanView.setupGenderType(type: .notcheck)
//            mainView.nextButton.setupBtType(type: .disable)
        }
        
    }
}
