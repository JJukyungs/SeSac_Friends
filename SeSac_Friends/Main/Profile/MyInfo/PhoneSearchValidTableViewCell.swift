//
//  PhoneSearchValidTableViewCell.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/04.
//

import UIKit
import SnapKit

class PhoneSearchValidTableViewCell: UITableViewCell {
    
    static let identifier = "PhoneSearchValidTableViewCell"
    
    let validLabel: UILabel = {
        let label = UILabel()
        label.text = "내 번호 검색 허용"
        label.font = UIFont.Title4_R14
        label.textColor = .blackColor
        return label
    }()
    
    // switch 추가 사항은 후에 추가
    let validSwitch: UISwitch = {
        let sw = UISwitch()
        sw.tintColor = .greenColor
        sw.isOn = true
        return sw
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
        addSubview(validLabel)
        addSubview(validSwitch)
    }
    
    func setupConstraints() {
        validLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(13)
            
        }
        
        validSwitch.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().offset(-3)
            make.height.equalTo(28)
        }
    }
}
