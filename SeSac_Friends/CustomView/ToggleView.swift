//
//  ToggleView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/04.
//

import UIKit
import SnapKit

class ToggleView: UIView {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Title1_M16
        label.textColor = .blackColor
        return label
    }()
    
    var arrowButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "more_arrow1"), for: .normal)
        return btn
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
        addSubview(titleLabel)
        addSubview(arrowButton)
        
    }
    
    func setupConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalTo(arrowButton.snp.leading).offset(-10)
        }
        
        arrowButton.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.top.bottom.trailing.equalToSuperview().inset(21)
        }
    }
}
