//
//  HomeView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/27.
//

import UIKit
import SnapKit


class HomeView: UIView {
    
    let testLabel: UILabel = {
        let label = UILabel()
        label.text = "dafsdfasfasdfsa"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(testLabel)
        
        testLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    
    
}
