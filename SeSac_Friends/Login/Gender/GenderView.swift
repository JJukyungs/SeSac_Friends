//
//  GenderView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/24.
//

import UIKit
import SnapKit


class GenderView: UIView {
    
    
    let titleStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "성별을 선택해 주세요"
        label.textAlignment = .center
        label.textColor = .blackColor
        label.font = UIFont.Display1_R20
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "새싹 찾기 기능을 이용하기 위해서 필요해요!"
        label.font = UIFont.Title2_R16
        label.textColor = .gray7Color
        label.textAlignment = .center
        return label
    }()
    
    // Button 대신 View로 만들어서 터치 이벤트 발생
    let manView: GenderImageView = {
        let view = GenderImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.imageView.image = UIImage(named: "man")
        view.genderLabel.text = "남자"
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray3Color?.cgColor
        return view
    }()
    
    let womanView: GenderImageView = {
        let view = GenderImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.imageView.image = UIImage(named: "woman")
        view.genderLabel.text = "여자"
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray3Color?.cgColor
        return view
    }()
    
    
    
    let nextButton: CustomButton = {
        let bt = CustomButton(frame: .zero, type: .disable, text: "다음")
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Gender error")
    }
    
    func setupView() {
        addSubview(titleStackView)
        titleStackView.addArrangedSubview(mainTitleLabel)
        titleStackView.addArrangedSubview(subTitleLabel)
        
        addSubview(manView)
        addSubview(womanView)
        
        addSubview(nextButton)
    }
    
    
    func setupConstraints() {
        
        titleStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(168)
            make.leading.trailing.equalToSuperview().inset(52)
            make.centerX.equalToSuperview()
            make.height.equalTo(66)
        }
        
        manView.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(womanView.snp.leading).offset(-11)
            make.height.equalTo(120)

        }
        
        womanView.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(32)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalTo(manView.snp.trailing).offset(11)
            make.width.equalTo(manView)
            make.height.equalTo(120)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(manView.snp.bottom).offset(72)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
        }
    }
}
