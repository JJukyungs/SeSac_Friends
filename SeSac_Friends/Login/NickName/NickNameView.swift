//
//  NickNameView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/23.
//

import UIKit

class NickNameView: UIView {
    
    
    let mainTitleLable: UILabel = {
        let label = UILabel()
        label.text = "닉네임을 입력해 주세요"
        label.font = UIFont.Display1_R20
        label.textColor = .blackColor
        label.textAlignment = .center
        return label
    }()
    
    let nickNameTextfield: CustomTextField = {
        let tf = CustomTextField(frame: .zero, type: .inactive)
        tf.textfield.placeholder = "10자 이내로 입력"
        return tf
    }()
    
    let nextButton: CustomButton = {
        let bt = CustomButton(frame: .zero, type: .disable, text: "다음")
        return bt
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }

    func setupView() {
        addSubview(mainTitleLable)
        addSubview(nickNameTextfield)
        addSubview(nextButton)
    }
    
    func setupConstraints() {
        
        mainTitleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(185)
            make.leading.trailing.equalToSuperview().inset(93)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
        }
        
        nickNameTextfield.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLable.snp.bottom).offset(80)
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextfield.snp.bottom).offset(72)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
        }
        
    }
}
