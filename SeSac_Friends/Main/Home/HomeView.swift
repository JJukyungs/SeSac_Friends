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
    
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 8
        return stack
    }()
    
    let manButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("남자", for: .normal)
        bt.titleLabel?.text = "남자"
        bt.titleLabel?.font = UIFont.Title3_M14
        bt.titleLabel?.textColor = .blackColor
        bt.backgroundColor = .white
        return bt
    }()

    let womanButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("여자", for: .normal)
        bt.titleLabel?.text = "여자"
        bt.titleLabel?.font = UIFont.Title3_M14
        bt.titleLabel?.textColor = .blackColor
        bt.backgroundColor = .white
        return bt
    }()
    
    let allButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("전체", for: .normal)
        bt.titleLabel?.font = UIFont.Title3_M14
        bt.titleLabel?.textColor = .blackColor
        bt.backgroundColor = .greenColor
        return bt
    }()
    
    let gpsButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "place"), for: .normal)
        return bt
    }()
    
    // 돋보기 : magnifyingglass
    // 전파 : antenna.radiowaves.left.and.right
    // 편지 : envelope
    
    let floatingButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        bt.clipsToBounds = true
        bt.layer.cornerRadius = bt.frame.size.width / 2
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
    }
    
}
