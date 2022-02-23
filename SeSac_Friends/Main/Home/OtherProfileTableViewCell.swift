//
//  OtherProfileTableViewCell.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/22.
//

import UIKit
import SnapKit


class OtherProfileTableViewCell: UITableViewCell {
    
    static let identifier = "OtherProfileTableViewCell"
    
    var toggleButtonAction: (() -> ())?
    var requestButtonAction: (() -> ())?
    
    
    lazy var otherProfileView: ProfileImageView = {
        let view = ProfileImageView(frame: .zero)
        view.backgroundImage.image = UIImage(named: "sesac_bg_01")
        view.sesacFaceImage.image = UIImage(named: "sesac_face_2")
        return view
    }()
    
    
    
    lazy var stackview: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = .whiteColor
        stack.distribution = .fill
        stack.layer.borderWidth = 1
        stack.layer.borderColor = UIColor.gray4Color?.cgColor
        stack.layer.cornerRadius = 8

        return stack
    }()
    
    // StackView 안에 들어갈 요소들
    
    lazy var toggleView: ToggleView = {
        let view = ToggleView(frame: .zero)
        view.titleLabel.text = "testestest"

        return view
    }()
    
//    let subView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .orange // 삭제해야함
//        return view
//    }()
    
    var subView = UIView()
    {
        didSet {
            subView.isHidden = true
        }
    }
    
    let sesacTitle: UILabel = {
        let label = UILabel()
        label.text = "새싹 타이틀"
        label.font = UIFont.Title6_R12
        return label
    }()
    
    let requtationView = ReputationView()
    
    
    @objc func toggleButtonClicked() {
        toggleButtonAction?()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    
        toggleView.arrowButton.addTarget(self, action: #selector(toggleButtonClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(otherProfileView)
        addSubview(stackview)
        stackview.addArrangedSubview(toggleView)
        stackview.addArrangedSubview(subView)
        subView.addSubview(sesacTitle)
        subView.addSubview(requtationView)
        
    }
    
    func setupConstraints() {
        
        otherProfileView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(stackview.snp.top)
            make.height.equalTo(194)
        }
        stackview.snp.makeConstraints { make in
            make.top.equalTo(otherProfileView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        toggleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        subView.snp.makeConstraints { make in
            make.top.equalTo(toggleView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        sesacTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }
        requtationView.snp.makeConstraints { make in
            make.top.equalTo(sesacTitle.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
//            make.height.equalTo(112)
            make.bottom.equalToSuperview()
        }
    }
}
