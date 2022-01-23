//
//  BirthdayViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/23.
//

import UIKit


class BirthdayViewController: UIViewController {
    
    let mainView = BirthdayView()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    
        
        mainView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    
    @objc func nextButtonClicked() {
        print("birth buttonclick")
        
        navigationController?.pushViewController(EmailViewController(), animated: true)
    }
}
