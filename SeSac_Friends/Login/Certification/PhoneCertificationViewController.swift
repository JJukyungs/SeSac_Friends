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
import Toast_Swift


class PhoneCertificationViewController: UIViewController {

    let mainView = PhoneCertificationView()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 네트워크 모니터 넣어줄거
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        mainView.phoneNumberTextfield.textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        mainView.sendMessageButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
        
        
        // bind
        
        LoginViewModel.shared.phoneNumber.bind { text in
            self.mainView.phoneNumberTextfield.textfield.text = text
        }
        
        LoginViewModel.shared.isvalidPhoneNumber.bind { valid in
            
        }
       
        
    }
    
    // 폰번호 포맷 맞추기
    
    @objc func textFieldDidChange(_ textfield: UITextField) {
        
        // viewModel 에 있는 phonNumber 로 값 넘기기
        LoginViewModel.shared.phoneNumber.value = mainView.phoneNumberTextfield.textfield.text ?? ""
       
        LoginViewModel.shared.phoneNumberAddHyphen()
        
        LoginViewModel.shared.nohypenNumber.value = LoginViewModel.shared.phoneNumber.value.components(separatedBy: ["-"]).joined()

        LoginViewModel.shared.validPhoneNumber(phoneNumber: LoginViewModel.shared.phoneNumber.value)
        
        
        if LoginViewModel.shared.isvalidPhoneNumber.value == true {
            
            print(LoginViewModel.shared.isvalidPhoneNumber.value)
           
            mainView.sendMessageButton.setupBtType(type: .fill)
            mainView.phoneNumberTextfield.setupTfType(type: .succes)
            mainView.phoneNumberTextfield.subLabel.text = "휴대폰 번호 형식에 맞게 잘 작성"


        } else {
            mainView.sendMessageButton.setupBtType(type: .disable)
            mainView.phoneNumberTextfield.setupTfType(type: .error)
            mainView.phoneNumberTextfield.subLabel.text = "휴대폰 번호 형식이 아닙니다."
        }
        
    }
    
    
    @objc func sendButtonClicked() {
        
        
        // 초기값은 fasle
        if LoginViewModel.shared.isvalidPhoneNumber.value {
            
            view.makeToast("휴대폰 번호 인증 시작")
            
            LoginViewModel.shared.requestPhoneNumber { verificationID, error in
                
                guard let verificationID = verificationID else {
                    
                    print("error", error.debugDescription)
                    print("error", error!.localizedDescription)
                    
                    return
                }
                
                print("인증번호 : \(verificationID)")
                
                LoginViewModel.shared.verificationID = verificationID
                self.view.makeToast("전화번호 인증 시작")
                
                self.navigationController?.pushViewController(InputCertificatinoViewController(), animated: true)
            }
        
        } else {
            view.makeToast("잘못된 전화번호 형식")
            view.endEditing(true)
        }
         
    }
    
}



