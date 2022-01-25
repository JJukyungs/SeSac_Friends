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
