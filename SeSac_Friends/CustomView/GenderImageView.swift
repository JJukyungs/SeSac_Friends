//
//  GenderImageView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/24.
//

import UIKit
import SnapKit

enum GenderType {
    case check
    case notcheck
}


class GenderImageView: UIView {
    
    var type: GenderType
    
    let imageView: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Title2_R16
        label.text = "testtest"
        label.textColor = .blackColor
        label.textAlignment = .center
        return label
    }()
    
    
    init(frame: CGRect, type: GenderType) {
        self.type = type
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
        setupGenderType(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Gender ImageView error")
    }

    func setupView() {
        
        addSubview(imageView)
        addSubview(genderLabel)
    }
    
    func setupConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.size.equalTo(64)
            make.centerX.equalToSuperview()
        }
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(2)
            make.height.equalTo(26)
            make.bottom.equalToSuperview().offset(-14)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupGenderType(type: GenderType) {
        self.type = type
        
        switch self.type {
            
        case .check:
            backgroundColor = .whitegreenColor
            layer.borderWidth = 0
        case .notcheck:
            backgroundColor = .whiteColor
            layer.borderWidth = 1
            layer.borderColor = UIColor.gray3Color?.cgColor
        }
    }
}
