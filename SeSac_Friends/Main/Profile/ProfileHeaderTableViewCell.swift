//
//  ProfileHeaderTableViewCell.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/28.
//

import UIKit

class ProfileHeaderTableViewCell: UITableViewCell {

    static let identifier = "ProfileHeaderTableViewCell"
    
    let profileImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "profile_img")
        return img
    }()
    
    let nameLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.Title1_M16
        label.textColor = .blackColor
        return label
    }()
    
    let moreButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "more_arrow"), for: .normal)
        return bt
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 유저의 이벤트가 event queue로부터 무시되고 있는지 삭제됐는지 판단하는 boolean 값
        contentView.isUserInteractionEnabled = true
        
        setupView()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    
    func setupView() {
        addSubview(profileImage)
        addSubview(nameLable)
        addSubview(moreButton)
    }
    
    func setupConstraints() {
        
        profileImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(1)
            make.bottom.equalToSuperview().offset(-26)
            make.size.equalTo(50)
        }
        
        nameLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(37)
            make.bottom.equalToSuperview().offset(-33)
            make.leading.equalTo(profileImage.snp.trailing).offset(13)
            make.trailing.equalTo(moreButton.snp.leading).offset(-10)
            make.height.equalTo(26)
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(39)
            make.trailing.equalToSuperview().offset(-7)
            make.width.equalTo(9)
            make.height.equalTo(18)
        }
        
    }
}
