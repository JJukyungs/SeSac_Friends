//
//  PopUpView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/26.
//

import UIKit
import SnapKit



class PopUpView: UIView {
    
    let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .whiteColor
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let buttonStackView: UIStackView = {
        let stack = UIStackView()
        
        return stack
    }()
    
    let cancelButton = CustomButton(frame: .zero, type: .cancel, text: "취소")
    
    let okButton = CustomButton(frame: .zero, type: .fill, text: "확인")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(contentView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(okButton)
        
    }
    
    func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
