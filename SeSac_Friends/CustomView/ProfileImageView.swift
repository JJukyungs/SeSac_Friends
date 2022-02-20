//
//  ProfileImageView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/03.
//

import UIKit
import SnapKit

class ProfileImageView: UIView {
    
    let backgroundImage: UIImageView = {
        let img = UIImageView()
        
        // 일단 임시로 이미지 넣어놓기 후에 이미지가 쉽게 바꿀수 잇게 해줘야함
//        img.image = UIImage(named: "sesac_bg_01")
        img.clipsToBounds = true
        img.layer.cornerRadius = 8
        img.contentMode = .scaleToFill
        return img
    }()
    
    let sesacFaceImage: UIImageView = {
        let img = UIImageView()
//        img.image = UIImage(named: "sesac_face_2")
        img.contentMode = .scaleToFill

        return img
    }()
    
    let matchButton: CustomButton = {
        let bt = CustomButton(frame: .zero, type: .fill, text: "테스트")
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
        addSubview(backgroundImage)
        addSubview(sesacFaceImage)
    }
    
    func setupConstraints() {
        
        backgroundImage.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        sesacFaceImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview().offset(9)
//            make.size.equalTo(backgroundImage.snp.height).multipliedBy(0.9)
            
            make.size.equalTo(184)
            make.bottom.equalTo(backgroundImage.snp.bottom).offset(9)
            
        }
    }
}
