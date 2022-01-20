//
//  OnBoardingViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/20.
//

import UIKit

class OnBoardingViewControll: UIViewController {
    
    
    let boardingView = OnBoardingView()
    
    override func loadView() {
        self.view = boardingView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray // 추후 삭제
        
        
    }
}

