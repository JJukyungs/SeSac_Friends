//
//  PhoneCertificationViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/18.
//

import UIKit
import Firebase
import FirebaseAuth
import SnapKit


class PhoneCertificationViewController: UIViewController {

    let mainView = PhoneCertificationView()
    
    
    
    
    
    // 인증 받을 때 사용
    var verifyID: String?
    
    var sendButtonStatus = false
    
    
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        mainView.phoneNumberTextfield.textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        mainView.sendMessageButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
        
    }
    
    // 폰번호 포맷 맞추기
    
    @objc func textFieldDidChange(_ textfield: UITextField) {
        
        
    }
    
    
    @objc func sendButtonClicked() {
        print("sendButtonClicked")
//        PhoneAuthProvider.provider().verifyPhoneNumber(mainView.phoneNumberTextfield.text ?? "", uiDelegate: nil) { varification, error in
//            if error == nil {
//                self.verifyID = varification
//            } else {
//                print("error", error.debugDescription)
//            }
//        }
        // test
        
        
        self.navigationController?.pushViewController(InputCertificatinoViewController(), animated: true)
        
    }
}



