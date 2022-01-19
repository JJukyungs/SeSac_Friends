//
//  ViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/17.
//

// 받아온 firebase 연결로 로그인 기능이 작동되는 지 확인

import UIKit
import SnapKit
import FirebaseAuth



class TestViewController: UIViewController {
    
    let phoneNumberTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "전화번호 입력"
        tf.backgroundColor = .lightGray
        return tf
    }()
    
    let certificationNumberTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "인증번호 입력"
        tf.backgroundColor = .lightGray
        return tf
    }()
    
    let sendButton: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .white
        return bt
    }()
    
    let doneButton: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .white

        return bt
    }()
    
    // 인증 받을 떄 사용
    var verifyID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        
        sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
    }

    
    @objc func doneButtonClicked() {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verifyID ?? "", verificationCode: certificationNumberTextField.text ?? "")
    
        Auth.auth().signIn(with: credential) { succes, error in
            if error == nil {
                print(succes ?? "")
                print("User Signed in...")
            } else {
                print(error.debugDescription)
            }
        }
    }

    
    @objc func sendButtonClicked() {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumberTextField.text ?? "", uiDelegate: nil) { varification, error in
            if error == nil {
                self.verifyID = varification
            } else {
                print("error", error.debugDescription)
            }
        }
    }
    
    
    func setUI() {
        self.view.addSubview(phoneNumberTextField)
        self.view.addSubview(certificationNumberTextField)
        self.view.addSubview(sendButton)
        self.view.addSubview(doneButton)
        
        phoneNumberTextField.snp.makeConstraints { make in
                  make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
                  make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
                  make.height.equalTo(44)
              }
              
        sendButton.snp.makeConstraints { make in
                  make.top.equalTo(phoneNumberTextField.snp.bottom).offset(30)
                  make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
                  make.height.equalTo(44)
              }
              
        certificationNumberTextField.snp.makeConstraints { make in
                  make.top.equalTo(sendButton.snp.bottom).offset(30)
                  make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
                  make.height.equalTo(44)
              }
        doneButton.snp.makeConstraints { make in
                  make.top.equalTo(certificationNumberTextField.snp.bottom).offset(30)
                  make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
                  make.height.equalTo(44)
              }
    }

    
    
}

