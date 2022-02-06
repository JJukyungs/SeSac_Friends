//
//  AgeTableViewCell.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/04.
//

import UIKit
import SnapKit
import RangeSeekSlider

class AgeTableViewCell: UITableViewCell {
    
    static let identifier = "AgeTableViewCell"
    
    lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "상대방 연령대"
        label.font = UIFont.Title4_R14
        label.textColor = .blackColor
        return label
    }()
    
    
    lazy var changeLabel: UILabel = {
        let label = UILabel()
        label.text = "18 - 35" // 임시
        label.textColor = .greenColor
        label.font = UIFont.Title3_M14
        return label
    }()
    
  
    lazy var doubleSlider: RangeSeekSlider = {
        
        let slider = RangeSeekSlider()
        slider.minValue = 18
        slider.maxValue = 65
        slider.handleColor = .greenColor
        slider.handleBorderColor = .whiteColor
        slider.colorBetweenHandles = .greenColor
        slider.tintColor = .gray2Color
        slider.hideLabels = true
        slider.minDistance = 1
        slider.step = 1
        slider.lineHeight = 4
        slider.enableStep = true
        
        
        return slider
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    
    func setupView() {
        addSubview(ageLabel)
        addSubview(changeLabel)
        addSubview(doubleSlider)
    }
    
    func setupConstraints() {
        
        ageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.leading.equalToSuperview()
            make.height.equalTo(22)
        }
        
        changeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.trailing.equalToSuperview()
            make.height.equalTo(22)
        }
        
        doubleSlider.snp.makeConstraints { make in
            make.top.equalTo(ageLabel.snp.bottom).offset(3)
            make.leading.trailing.equalToSuperview()
            
            make.bottom.equalToSuperview()
            
        }
      
    }
}
