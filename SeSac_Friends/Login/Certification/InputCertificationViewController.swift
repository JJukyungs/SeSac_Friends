//
//  InputCertificationViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/23.
//

import UIKit
import Firebase
import FirebaseAuth


class InputCertificatinoViewController: UIViewController {
    
    let mainView = InputCertificationView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        mainView.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        
        mainView.resendButton.addTarget(self, action: #selector(resendButtonClicked), for: .touchUpInside)
    }
    
    
    
    @objc func startButtonClicked() {
        print("startButton Click")
        
        navigationController?.pushViewController(NickNameViewController(), animated: true)
    }
    
    @objc func resendButtonClicked() {
        print("resendButton Click")
    }
}
