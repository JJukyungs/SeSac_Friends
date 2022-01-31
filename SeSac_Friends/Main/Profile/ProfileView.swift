//
//  ProfileView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/27.
//

import UIKit
import SnapKit


class ProfileView: UIView {
    
    var tableView = UITableView()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupView()
        setupConstraints()
      
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    
    func setupView() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-250)
        }
    }
}
