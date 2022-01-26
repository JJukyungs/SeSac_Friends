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
        mainView.nickNameTextfield.textfield.addTarget(self, action: #selector(nicknameTextfieldChanged), for: .editingChanged)
    
    
    }
    
    @objc func nextbuttonClicked() {
        print("nextbutton clicked")
        
        self.view.endEditing(true)
        if LoginViewModel.shared.isvalidNickname.value {
    
            navigationController?.pushViewController(BirthdayViewController(), animated: true)
        } else {
            view.endEditing(true)
            view.makeToast("닉네임은 1자 이상 10자 이하로 작성하시오")
            
        }
       
    }

    @objc func nicknameTextfieldChanged() {
        
        LoginViewModel.shared.nickname.value = mainView.nickNameTextfield.textfield.text ?? ""
        
        LoginViewModel.shared.validNickname(nickname: LoginViewModel.shared.nickname.value)
        
        if LoginViewModel.shared.isvalidNickname.value == true {
            
            mainView.nickNameTextfield.setupTfType(type: .succes)
            mainView.nickNameTextfield.subLabel.text = "닉네임 형식에 맞습니다."
            mainView.nextButton.setupBtType(type: .fill)
            
        } else {
            
            mainView.nickNameTextfield.setupTfType(type: .error)
            mainView.nickNameTextfield.subLabel.text = "닉네임 형식에 안 맞습니다."
            mainView.nextButton.setupBtType(type: .disable)
            
        }
        
    }
}
