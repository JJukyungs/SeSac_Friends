//
//  NickNameViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/23.
//

import UIKit

class NickNameViewController: UIViewController {
    
    let mainView = NickNameView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        mainView.nextButton.addTarget(self, action: #selector(nextbuttonClicked), for: .touchUpInside)
        
    }
    
    @objc func nextbuttonClicked() {
        print("nextbutton clicked")
        
        navigationController?.pushViewController(BirthdayViewController(), animated: true)
    }
}
