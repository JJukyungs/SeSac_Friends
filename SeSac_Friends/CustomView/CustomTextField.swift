//
//  CustomTextField.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/22.
//

import UIKit
import SnapKit


enum CustomTextFieldType {
    case inactive
    case focus
    case active
    case disable
    case error
    case succes
}


// contentView 만들고 밑줄 라인 뷰랑 라벨 하나씩 붙여서 커스텀 텍스필드 만들기

class CustomTextField: UIView {
    
    var type: CustomTextFieldType
    
    let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        return view
    }()

    let textfield: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .clear
        tf.font = UIFont.Title4_R14
        tf.placeholder = "내용을 입력"
        return tf
    }()

    let bottomLine = UIView()

    let subLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.font = .Body4_R12
        return label
    }()
    
    init(frame: CGRect, type: CustomTextFieldType) {
        
        self.type = type
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
        setupTfType(type: type)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("CustomTextField Error")
    }
    
   
    
    func setupUI() {
        addSubview(contentView)
        contentView.addSubview(textfield)
        contentView.addSubview(bottomLine)
        addSubview(subLabel)
    }
    
    func setupConstraints() {
        // 위치 잡아주기
        
        // 텍스트 필드 -> 언더바 (12) -> 서브라벨 (4)
        // 컨테이너뷰 48,텍스트필드 22, 서브라벨 22
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        textfield.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(22)
        }
        
        bottomLine.snp.makeConstraints { make in
            make.top.equalTo(textfield.snp.bottom).offset(12)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(1)
            
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(22)
        }
        
        
    }
    
    
    
    func setupTfType(type: CustomTextFieldType) {
        
        self.type = type
        
        switch self.type {
            
        case .inactive:
            textfield.textColor = .gray7Color
            bottomLine.backgroundColor = .gray3Color
        
        case .focus:
            textfield.textColor = .blackColor
            bottomLine.backgroundColor = .focusColor
            
        case .active:
            textfield.textColor = .blackColor
            bottomLine.backgroundColor = .gray3Color
            
        case .disable:
            textfield.textColor = .gray3Color
            bottomLine.backgroundColor = .clear
            
        case .error:
            textfield.textColor = .blackColor
            bottomLine.backgroundColor = .errorColor
            subLabel.textColor = .errorColor
            subLabel.isHidden = false
            
        case .succes:
            textfield.textColor = .blackColor
            bottomLine.backgroundColor = .successColor
            subLabel.textColor = .successColor
            subLabel.isHidden = false
        }
    }
    
}
