//
//  GenderViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/24.
//

import UIKit


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
    }
    
    
    @objc func nextButtonClicked() {
        
        if LoginViewModel.shared.gender.value != -1 {
            print("회원가입 기능 완성")
        }
        
        
        // test 용
//        navigationController?.pushViewController(TestViewController(), animated: false)
    }
    
    @objc func tapManImageView(_ sender: UITapGestureRecognizer) {
        
        
        if LoginViewModel.shared.gender.value != 1 {
            LoginViewModel.shared.gender.value = 1
            mainView.manView.setupGenderType(type: .check)
            mainView.womanView.setupGenderType(type: .notcheck)
            mainView.nextButton.setupBtType(type: .fill)
        } else {
            LoginViewModel.shared.gender.value = -1
            mainView.manView.setupGenderType(type: .notcheck)
            mainView.nextButton.setupBtType(type: .disable)
        }
        
        
    }
    @objc func tapWomanImageView(_ sender: UITapGestureRecognizer) {
        
        if LoginViewModel.shared.gender.value != 0 {
            LoginViewModel.shared.gender.value = 0
            mainView.manView.setupGenderType(type: .notcheck)
            mainView.womanView.setupGenderType(type: .check)
            mainView.nextButton.setupBtType(type: .fill)
        } else {
            LoginViewModel.shared.gender.value = -1
            mainView.womanView.setupGenderType(type: .notcheck)
            mainView.nextButton.setupBtType(type: .disable)
        }
        
    }
}
