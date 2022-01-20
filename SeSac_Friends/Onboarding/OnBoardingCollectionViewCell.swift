//
//  OnBoardingCollectionViewCell.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/20.
//

import UIKit
import SnapKit


class OnBoardingCollectionViewCell: UICollectionViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "testtestestestestest"
        return label
    }()
    
    var boardingImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "onboarding_img1")
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("error!")
    }
    
    func setUI() {
        addSubview(titleLabel)
        addSubview(boardingImageView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(116)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(85)
            make.height.equalTo(76)
        }
        
        boardingImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(56)
            make.leading.trailing.equalToSuperview().inset(7)
            make.size.equalTo(360) // 나중에 수정해야함
            make.bottom.equalToSuperview()
        }
    }
}
