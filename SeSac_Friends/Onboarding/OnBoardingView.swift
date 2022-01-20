//
//  OnBoardingView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/20.
//

import Foundation
import UIKit

class OnBoardingView: UIView {
    
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        
        return collectionView
    }()
    
    let pageControll: UIPageControl = {
        let pageControll = UIPageControl()
        pageControll.numberOfPages = 3
        pageControll.pageIndicatorTintColor = UIColor.blackColor
        return pageControll
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(collectionView)
    
    }
    
    
    func setupConstraints() {
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()()
            make.leading.equalToSuperview().offset(7)
            make.trailing.equalToSuperview().offset(-8)
            
        }
        
        pageControll.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(3)
            
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(pageControll.snp.bottom).offset(42)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(48)
        }
        
        
    }
}
