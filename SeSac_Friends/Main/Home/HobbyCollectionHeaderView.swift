//
//  HobbyCollectionHeaderView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/14.
//

import UIKit
import SnapKit


class HobbyCollectionHeaderView: UICollectionReusableView {
    
    static let identifier = "HobbyCollectionHeaderView"
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Title6_R12
        label.textColor = .blackColor
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
        addSubview(headerView)
        headerView.addSubview(headerTitleLabel)
    }
    
    func setupConstraints() {
        
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        headerTitleLabel.snp.makeConstraints { make in

            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()

        }
    }
    
}

