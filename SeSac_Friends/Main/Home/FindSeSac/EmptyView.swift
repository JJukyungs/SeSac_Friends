//
//  EmptyView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/21.
//

import UIKit
import SnapKit


class EmptyView: UIView {
    
    let sesacImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "emptyImage")
        return img
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Display1_R20
        label.textColor = .blackColor
        label.textAlignment = .center
        return label
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Title4_R14
        label.textColor = .gray7Color
        label.text = "취미를 변경하거나 조금만 더 기다려 주세요!"
        label.textAlignment = .center
        return label
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
        addSubview(sesacImage)
        addSubview(titleLabel)
        addSubview(subLabel)
    }
    
    func setupConstraints() {
        
        sesacImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
            make.size.equalTo(64)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(sesacImage.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
        }
        
        
    }
    
}
