//
//  GenderTableViewCell.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/03.
//

import UIKit
import SnapKit




class GenderTableViewCell: UITableViewCell {
    
    static let identifier = "GenderTableViewCell"
    
    // closer로 cell button Action
    var manButtonClickAction: (() -> ())?
    var womanButtonClickAction: (() -> ())?
    
    lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.text = "내 성별"
        label.font = UIFont.Title4_R14
        return label
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var manButton = CustomButton(frame: .zero, type: .inactive, text: "남자")
    
    lazy var womanButton = CustomButton(frame: .zero, type: .inactive, text: "여자")
    
    
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
        
        
        

        self.manButton.addTarget(self, action: #selector(manButtonClicked), for: .touchUpInside)

        self.womanButton.addTarget(self, action: #selector(womanButtonClicked), for: .touchUpInside)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
   
    @objc func manButtonClicked() {
        print("manButton Click")
        manButtonClickAction?()
    }
    
    @objc func womanButtonClicked() {
        print("womanButton Click")
        womanButtonClickAction?()
    }
   
    
    func setupView() {
        
        addSubview(genderLabel)
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(manButton)
        buttonStackView.addArrangedSubview(womanButton)
    }
    
    func setupConstraints() {
        
        genderLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(13)
            make.leading.equalToSuperview()
            make.trailing.equalTo(buttonStackView.snp.leading).offset(-20)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(120)
        }
        
        manButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            
        }
        
        womanButton.snp.makeConstraints { make in
            make.height.equalTo(48)
           
        }
    }
}
