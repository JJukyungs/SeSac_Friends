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
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        
        return collectionView
    }()
    
    let pageControll: UIPageControl = {
        let pageControll = UIPageControl()
        pageControll.numberOfPages = 3
        pageControll.pageIndicatorTintColor = UIColor.gray5Color
        pageControll.currentPageIndicatorTintColor = UIColor.blackColor
        return pageControll
    }()
    

    
    let startButton = CustomButton(frame: .zero, type: .fill, text: "시작하기")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(collectionView)
        addSubview(pageControll)
        addSubview(startButton)
    
    }
    
    
    func setupConstraints() {
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(self.safeAreaLayoutGuide)
            make.trailing.equalTo(self.safeAreaLayoutGuide)
            
        }
        
        pageControll.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(56)
            make.centerX.equalToSuperview()
            
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(pageControll.snp.bottom).offset(42)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(48)
        }
        
        
    }
}
