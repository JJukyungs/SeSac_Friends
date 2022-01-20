//
//  OnBoardingCollectionViewCell.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/20.
//

import UIKit
import SnapKit


class OnBoardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "OnBoardingCollectionViewCell"
    
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansCJKkr-Medium", size: 24)
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
    
    func setup(_ slide: OnBoardingSlide) {
        boardingImageView.image = slide.image
        titleLabel.text = slide.title
    }
    
    
    func setUI() {
        addSubview(titleLabel)
        addSubview(boardingImageView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
//            make.leading.trailing.equalToSuperview().inset(85)
            make.width.equalTo(280)
            make.height.equalTo(76)
        }
        
        boardingImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(56)
            make.centerX.equalToSuperview()
            make.width.equalTo(360)
            make.height.equalTo(360)
            make.bottom.equalToSuperview()
        }
    }
}
