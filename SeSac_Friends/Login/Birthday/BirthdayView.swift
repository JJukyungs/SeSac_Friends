//
//  BirthdayView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/23.
//

import UIKit


class BirthdayView: UIView {
    
    let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.Display1_R20
        label.textColor = .blackColor
        label.text = "생년월일을 알려주세요"
        return label
    }()
    
    // 하나의 스택뷰에 다 넣는 게 아니라 스택 뷰 안에 3개의 스택뷰로 넣었다.. 늦게 확인했네
    
    let birthStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    //  99 x 48 사이즈 ( 텍스트필드 + 라벨)
    let yearStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    let yearTexfield: CustomTextField = {
        let tf = CustomTextField(frame: .zero, type: .inactive)
        tf.textfield.placeholder = "1990"
        return tf
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "년"
        label.textColor = .blackColor
        label.font = UIFont.Title2_R16
        label.textAlignment = .center
        return label
    }()
    
    let monthStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    let monthTexfield: CustomTextField = {
        let tf = CustomTextField(frame: .zero, type: .inactive)
        tf.textfield.placeholder = "1"
        return tf
    }()
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        label.textColor = .blackColor
        label.font = UIFont.Title2_R16
        label.textAlignment = .center
        return label
    }()
    
    let dayStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    let dayTexfield: CustomTextField = {
        let tf = CustomTextField(frame: .zero, type: .inactive)
        tf.textfield.placeholder = "1"
        return tf
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "일"
        label.textColor = .blackColor
        label.font = UIFont.Title2_R16
        label.textAlignment = .center
        return label
    }()
    
    let nextButton: CustomButton = {
        let bt = CustomButton(frame: .zero, type: .disable, text: "다음")
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraint()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    func setupView() {
        addSubview(mainTitleLabel)
        addSubview(birthStackView)
        
        birthStackView.addArrangedSubview(yearStackView)
        yearStackView.addArrangedSubview(yearTexfield)
        yearStackView.addArrangedSubview(yearLabel)
        
        birthStackView.addArrangedSubview(monthStackView)
        monthStackView.addArrangedSubview(monthTexfield)
        monthStackView.addArrangedSubview(monthLabel)
        
        birthStackView.addArrangedSubview(dayStackView)
        dayStackView.addArrangedSubview(dayTexfield)
        dayStackView.addArrangedSubview(dayLabel)
        
        addSubview(nextButton)
    }
    
    
    func setupConstraint() {
        
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(185)
            make.leading.trailing.equalToSuperview().inset(93)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
        }
        
        birthStackView.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(80)
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
        }
        
        // yearstackview 는 해야하나?
        
        yearTexfield.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(yearLabel.snp.leading)
            make.bottom.equalToSuperview()
        }
        
        yearLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        monthTexfield.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(monthLabel.snp.leading)
            make.bottom.equalToSuperview()
        }
        
        monthLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        dayTexfield.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(dayLabel.snp.leading)
            make.bottom.equalToSuperview()
        }
        
        dayLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(birthStackView.snp.bottom).offset(72)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
        }
        
    }
    
    
    
}
