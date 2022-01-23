//
//  InputCertificationView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/22.
//

import UIKit
import SnapKit


class InputCertificationView: UIView {
    
    let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .blackColor
        label.font = UIFont.Display1_R20
        label.text = "인증번호가 문자로 전송되었어요"
        label.textAlignment = .center
        return label
    }()
    
    let subtitleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.Title2_R16
        label.textColor = .gray7Color
        label.text = "(최대 소모 60초)"
        label.textAlignment = .center
        return label
    }()
    

    let certificationTextField: CustomTextField = {
        let tf = CustomTextField(frame: .zero, type: .inactive)
        tf.textfield.keyboardType = .numberPad
        tf.textfield.placeholder = "인증번호 입력"
        return tf
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .greenColor
        label.text = "1:00"
        label.textAlignment = .center
        label.baselineAdjustment = .alignCenters
        return label
    }()
    
    let resendButton: CustomButton = {
        let bt = CustomButton(frame: .zero, type: .fill, text: "재전송")
        
        return bt
    }()
    
    let startButton: CustomButton = {
        let bt = CustomButton(frame: .zero, type: .disable, text: "인증하고 시작하기")
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("InputCertificationVIew Error")
    }
    
    func setupView() {
        addSubview(mainTitleLabel)
        addSubview(subtitleLable)
        addSubview(certificationTextField)
        addSubview(timerLabel)
        addSubview(resendButton)
        addSubview(startButton)
    }
    
    func setupConstraints() {
        
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(170)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(74)
            make.height.equalTo(32)
        }
        
        subtitleLable.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(132)
            make.centerX.equalToSuperview()
            make.height.equalTo(26)
        }
        
        certificationTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLable.snp.bottom).offset(66)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(resendButton.snp.leading).offset(8)
            make.height.equalTo(36)
        }
        
        resendButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLable.snp.bottom).offset(72)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(72)
            make.height.equalTo(40)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLable.snp.bottom).offset(72)
            make.trailing.equalTo(resendButton.snp.leading).offset(-20)
            make.width.equalTo(37)
            make.height.equalTo(22)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(certificationTextField.snp.bottom).offset(72)
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
        }
        
    }
    
    
}
