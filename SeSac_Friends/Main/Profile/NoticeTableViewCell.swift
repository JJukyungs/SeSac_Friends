//
//  NoticeTableViewCell.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/31.
//

import UIKit
import SnapKit

class NoticeTableViewCell: UITableViewCell {
    
    static let identifier = "NoticeTableViewCell"
    
    let iconImage: UIImageView = {
        let img = UIImageView()
        
        return img
    }()
    
    
    let noticeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Title2_R16
        label.textColor = .blackColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    func setupView() {
        addSubview(iconImage)
        addSubview(noticeLabel)
    }
    
    func setupConstraints() {
        
        iconImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(24)
            make.leading.equalToSuperview().offset(1)
            make.size.equalTo(24)
        }
        
        noticeLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(24)
            make.leading.equalTo(iconImage.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
    }
}
