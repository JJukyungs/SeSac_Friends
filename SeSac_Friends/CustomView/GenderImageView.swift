//
//  GenderImageView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/24.
//

import UIKit
import SnapKit


class GenderImageView: UIView {
    
    
    let imageView: UIImageView = {
        let img = UIImageView()
        // 이미지는 여기 말고 다른 GenderView에서
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
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
}
