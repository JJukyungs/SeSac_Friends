//
//  Extension+UIButton.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/19.
//

import UIKit

enum CustomButtonType {
    case inactive
    case fill
    case outline
    case cancel
    case disable
}


class CustomButton: UIButton {
    
    var type: CustomButtonType
    var text: String
    
    init(frame: CGRect, type: CustomButtonType, text: String) {
        
        self.type = type
        self.text = text
        
        super.init(frame: frame)
        
        setupBtType(type: type)
        setupBt(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("custom Button error")
    }
    
    
    func setupBtType(type: CustomButtonType) {
        self.type = type
        
        switch self.type {
            
        case .inactive:
            backgroundColor = .whiteColor
            setTitleColor(.blackColor, for: .normal)
            layer.borderWidth = 1
            layer.borderColor = UIColor.gray6Color?.cgColor
            isEnabled = true

        case .fill:
            backgroundColor = .greenColor
            setTitleColor(.whiteColor, for: .normal)
            isEnabled = true
        case .outline:
            backgroundColor = .whiteColor
            layer.borderWidth = 1
            layer.borderColor = UIColor.greenColor?.cgColor
            isEnabled = true

        case .cancel:
            backgroundColor = .gray2Color
            setTitleColor(.blackColor, for: .normal)
            isEnabled = true

        case .disable:
            backgroundColor = .gray6Color
            setTitleColor(.gray3Color, for: .normal)
            isEnabled = false
        }
    }
    
    func setupBt(text: String) {
        setTitle(text, for: .normal)
        titleLabel?.font = UIFont.Body3_R14
        clipsToBounds = true
        layer.cornerRadius = 8
    }
   
}
