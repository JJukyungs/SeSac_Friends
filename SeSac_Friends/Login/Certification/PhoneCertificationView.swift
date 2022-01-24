//
//  PhoneCertificationView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/18.
//

import Foundation
import UIKit


class PhoneCertificationView: UIView {
    

    
    
    let mainTextLabl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
//        label.font = .systemFont(ofSize: 20)
        label.font = UIFont.Display1_R20
        label.text = "새싹 서비스 이용을 위해 \n 휴대폰 번호를 입력해주세요"
        label.textAlignment = .center
        return label
    }()
    

    let phoneNumberTextfield : CustomTextField = {
        let phoneTf = CustomTextField(frame: .zero, type: .inactive)
        phoneTf.textfield.placeholder = "휴대폰번호(-없이 숫자만 입력)"
        phoneTf.textfield.keyboardType = .numberPad
        return phoneTf
    }()
    
    
    // 비활성화 먼저 보여주기
    let sendMessageButton: CustomButton = {
        let bt  = CustomButton(frame: .zero, type: .disable, text: "인증 문자 받기")
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setupView() {
        addSubview(mainTextLabl)
        addSubview(phoneNumberTextfield)
        addSubview(sendMessageButton)
       
    
    }
    
    func setupConstraints() {
        
        mainTextLabl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(170)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(74)
            make.trailing.equalToSuperview().offset(-74)
            make.height.equalTo(64)
        }
        
        phoneNumberTextfield.snp.makeConstraints { make in
            make.top.equalTo(mainTextLabl.snp.bottom).offset(77)
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
        }
        
        sendMessageButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextfield.snp.bottom).offset(72)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
      
    }
}
