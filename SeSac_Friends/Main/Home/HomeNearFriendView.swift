//
//  HomeNearFriendView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/16.
//

import UIKit


class HomeNearFriendView: UIView {
    
    let changeHobbyButton: CustomButton = {
        let bt = CustomButton(frame: .zero, type: .fill, text: "취미 변경하기")
        return bt
    }()
    
    let refreshButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "refresh"), for: .normal)
        bt.layer.borderColor = UIColor.greenColor?.cgColor
        bt.layer.borderWidth = 1
        bt.backgroundColor = .whiteColor
        bt.clipsToBounds = true
        bt.layer.cornerRadius = 8
        return bt
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(changeHobbyButton)
        addSubview(refreshButton)
    }
    
    func setupConstraints() {
        
        refreshButton.snp.makeConstraints { make in
            make.size.equalTo(48)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(50)
        }
        
        changeHobbyButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(refreshButton.snp.leading).offset(-8)
            make.height.equalTo(48)
        }
        
        
    }
}
