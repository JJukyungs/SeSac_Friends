//
//  withdrawTableViewCell.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/06.
//

import UIKit
import SnapKit


class WithdrawTableViewCell: UITableViewCell {
    
    static let identifier = "WithdrawTableViewCell"
    
    lazy var withdrawLabel: UILabel = {
        let label = UILabel()
        label.text = "회원탈퇴"
        label.font = UIFont.Title4_R14
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
        addSubview(withdrawLabel)
    }
    
    func setupConstraints() {
        withdrawLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(13)
            make.leading.equalToSuperview()
            make.height.equalTo(22)
        }
    }
}
