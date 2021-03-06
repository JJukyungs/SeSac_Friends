//
//  HomeView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/27.
//

import UIKit
import SnapKit
import MapKit

class HomeView: UIView {
    
    
    let mapView = MKMapView()
    
    let centerPin: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "map_marker")
        
        return img
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 8
        stack.layer.borderWidth = 1
        stack.layer.borderColor = UIColor.gray5Color?.cgColor
        return stack
    }()
    
    let manButton: CustomButton = {
        let bt = CustomButton(frame: .zero, type: .inactive, text: "남자")
        bt.layer.cornerRadius = 0
        bt.layer.borderWidth = 0
        bt.tag = 1
        return bt
    }()

    let womanButton: CustomButton = {
        let bt = CustomButton(frame: .zero, type: .inactive, text: "여자")
        bt.layer.cornerRadius = 0
        bt.layer.borderWidth = 0
        bt.tag = 0
        return bt
    }()
    
    let allButton: CustomButton = {
        let bt = CustomButton(frame: .zero, type: .inactive, text: "전체")
        bt.layer.cornerRadius = 0
        bt.layer.borderWidth = 0
        bt.tag = 2
        return bt
    }()
  
    // Button 을 CustomButton으로 바꿔주기... 이걸 왜 지금할까
//    let allsButton: CustomButton = {
//        let bt = CustomButton(frame: .zero, type: .inactive, text: "전체")
//
//        return bt
//    }()
    
    let gpsButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "place"), for: .normal)
        bt.backgroundColor = .whiteColor
        bt.clipsToBounds = true
        bt.layer.cornerRadius = 8
        
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor.gray5Color?.cgColor
        return bt
    }()
    
    // 돋보기 : magnifyingglass
    // 전파 : antenna.radiowaves.left.and.right
    // 편지 : envelope
    
    let floatingButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        bt.clipsToBounds = true
        bt.layer.cornerRadius = 32 // 64라는 고정값을 줘서 32로함
        bt.backgroundColor = .blackColor
        bt.tintColor = .whiteColor
        bt.layer.borderWidth = 1
        bt.setPreferredSymbolConfiguration(.init(pointSize: 30, weight: .regular, scale: .default), forImageIn: .normal)
        return bt
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
        addSubview(mapView)
        addSubview(stackView)
        stackView.addArrangedSubview(allButton)
        stackView.addArrangedSubview(manButton)
        stackView.addArrangedSubview(womanButton)
        addSubview(gpsButton)
        addSubview(floatingButton)
        addSubview(centerPin)
    }
    
    
    func setupConstraints() {
        
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(52)
            make.width.equalTo(52)
        }
        
        manButton.snp.makeConstraints { make in
            make.size.equalTo(52)
        }
        womanButton.snp.makeConstraints { make in
            make.size.equalTo(52)
        }
        allButton.snp.makeConstraints { make in
            make.size.equalTo(52)
        }
        
        gpsButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(52)
        }
        
        floatingButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-102)
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(64)
        }
        
        centerPin.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(48)
        }
    }
    
}
