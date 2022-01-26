//
//  EmailViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/24.
//

import UIKit
import Toast_Swift


class EmailViewController: UIViewController {
    
    let mainView = EmailView()
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        mainView.nextButton.addTarget(self, action: #selector(nextbuttonClicked), for: .touchUpInside)
    
        mainView.emailTextfield.textfield.addTarget(self, action: #selector(emailTextfieldChanged), for: .editingChanged)
        
        // 닉네임뷰로 다시 되돌아갔을 시 다시 보여주기 위해 bind로 묶어버리깅
        LoginViewModel.shared.email.bind { email in
            self.mainView.emailTextfield.textfield.text = email
        }
        
        LoginViewModel.shared.isValidEmial.bind { valid in
            if valid {
                self.mainView.nextButton.setupBtType(type: .fill)
            }
        }
        
    }
    
    
    @objc func nextbuttonClicked() {
        print("email nextbuttonclick")
        
        navigationController?.pushViewController(GenderViewController(), animated: true)
    }
    
    @objc func emailTextfieldChanged() {
        
        LoginViewModel.shared.email.value = mainView.emailTextfield.textfield.text ?? ""
        LoginViewModel.shared.validEmail(email: LoginViewModel.shared.email.value)
        
        if LoginViewModel.shared.isValidEmial.value {
            
            mainView.emailTextfield.setupTfType(type: .succes)
            mainView.emailTextfield.subLabel.text = "이메일 형식이 맞습니다."
            mainView.nextButton.setupBtType(type: .fill)
            
        } else {
            
            mainView.emailTextfield.setupTfType(type: .error)
            mainView.emailTextfield.subLabel.text = "이메일 형식이 아닙니다."
            mainView.nextButton.setupBtType(type: .disable)
        }
    }
}
