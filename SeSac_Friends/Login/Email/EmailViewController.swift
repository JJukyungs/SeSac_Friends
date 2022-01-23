//
//  EmailViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/24.
//

import UIKit


class EmailViewController: UIViewController {
    
    let mainView = EmailView()
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        mainView.nextButton.addTarget(self, action: #selector(nextbuttonClicked), for: .touchUpInside)
    }
    
    @objc func nextbuttonClicked() {
        print("email nextbuttonclick")
        
        navigationController?.pushViewController(GenderViewController(), animated: true)
    }
}
