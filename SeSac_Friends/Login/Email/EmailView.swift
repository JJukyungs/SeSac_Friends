//
//  EmailView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/24.
//

import UIKit
import SnapKit

class EmailView: UIView {
    
    let titleStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일을 입력해주세요"
        label.textAlignment = .center
        label.textColor = .blackColor
        label.font = UIFont.Display1_R20
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "휴대폰 번호 변경 시 인증을 위해 사용해요"
        label.font = UIFont.Title2_R16
        label.textColor = .gray7Color
        label.textAlignment = .center
        return label
    }()
    
    let emailTextfield: CustomTextField = {
        let email = CustomTextField(frame: .zero, type: .inactive)
        email.textfield.placeholder = "SeSAC@email.com"
        return email
    }()
    
    let nextButton: CustomButton = {
        let bt = CustomButton(frame: .zero, type: .disable, text: "다음")
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstratint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    func setupView() {
        
        addSubview(titleStackView)
        titleStackView.addArrangedSubview(mainTitleLabel)
        titleStackView.addArrangedSubview(subTitleLabel)
        
        addSubview(emailTextfield)
        addSubview(nextButton)
    }
    
    func setupConstratint() {
        
        titleStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(168)
            make.leading.trailing.equalToSuperview().inset(52)
            make.centerX.equalToSuperview()
            make.height.equalTo(66)
        }
       
        emailTextfield.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(62)
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextfield.snp.bottom).offset(72)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
        }
    }
}
