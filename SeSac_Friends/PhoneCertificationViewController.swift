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

    let certificationView = PhoneCertificationView()
    
    
    // 인증 받을 때 사용
    var verifyID: String?
    
    var sendButtonStatus = false
    
    
    
    override func loadView() {
        self.view = certificationView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    
    @objc func sendButtonClicked() {
        
        PhoneAuthProvider.provider().verifyPhoneNumber(certificationView.phoneNumberTextfield.text ?? "", uiDelegate: nil) { varification, error in
            if error == nil {
                self.verifyID = varification
            } else {
                print("error", error.debugDescription)
            }
        }

        
    }
}
