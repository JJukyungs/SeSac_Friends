//
//  BackgroundTableViewCell.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/04.
//

import UIKit
import SnapKit

class BackgroundTableViewCell: UITableViewCell {
    
    static let identifier = "BackgroundTableViewCell"
    
    var toggleButtonAction: (() -> ())?
    
    lazy var profileView: ProfileImageView = {
        let view = ProfileImageView(frame: .zero)
        view.backgroundImage.image = UIImage(named: "sesac_bg_01")
        view.sesacFaceImage.image = UIImage(named: "sesac_face_2")
        return view
    }()
    
    
    lazy var toggleView: ToggleView = {
        let view = ToggleView(frame: .zero)
        view.titleLabel.text = "testestest"
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray4Color?.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    
    // 스택뷰에 넣어보자
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
        
        toggleView.arrowButton.addTarget(self, action: #selector(toggleButtonClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    @objc func toggleButtonClicked() {
        toggleButtonAction?()
    }
    
    func setupView() {
        contentView.addSubview(profileView)
        contentView.addSubview(toggleView)
    }
    
    func setupConstraints() {
        
        profileView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(toggleView.snp.top)
            
        }
        
        toggleView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
            make.bottom.equalToSuperview()
        }
        
    }
}
