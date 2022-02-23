//
//  ReputationView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/23.
//

import UIKit
import SnapKit



class ReputationView: UIView {
    
    
    // views
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()
    
    let firstStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()

    let secondStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()
    
    let thirdStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()
    
    // buttons
    
    let mannerButton = CustomButton(frame: .zero, type: .inactive, text: "좋은 매너")
    let timeButton = CustomButton(frame: .zero, type: .inactive, text: "정확한 시간 약속")
    let fastButton = CustomButton(frame: .zero, type: .inactive, text: "빠른 응답")
    let kindButton = CustomButton(frame: .zero, type: .inactive, text: "친절한 성격")
    let hobbyButton = CustomButton(frame: .zero, type: .inactive, text: "능숙한 취미 실력")
    let goodButton = CustomButton(frame: .zero, type: .inactive, text: "유익한 시간")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(stackView)
        stackView.addArrangedSubview(firstStackView)
        firstStackView.addArrangedSubview(mannerButton)
        firstStackView.addArrangedSubview(timeButton)
        stackView.addArrangedSubview(secondStackView)
        secondStackView.addArrangedSubview(fastButton)
        secondStackView.addArrangedSubview(kindButton)
        stackView.addArrangedSubview(thirdStackView)
        thirdStackView.addArrangedSubview(hobbyButton)
        thirdStackView.addArrangedSubview(goodButton)
        
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        [firstStackView, secondStackView, thirdStackView].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(32)
            }
        }
    }
}
