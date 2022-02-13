//
//  HomeHobbyView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/13.
//

import UIKit
import SnapKit


class HomeHobbyView: UIView {
    
    let searchbar = UISearchBar()
    
    let searchButton: CustomButton = {
        let bt = CustomButton(frame: .zero, type: .fill, text: "새싹 찾기")
        return bt
    }()
    
    let hobbyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.isScrollEnabled = false
        collectionView.collectionViewLayout = layout
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    // 자동 추가하면 이게 뜨는구나... 왜 자동으로 쳤지?
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(searchButton)
        addSubview(hobbyCollectionView)
    }
    
    func setupConstraints() {
        
        searchButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        hobbyCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            
        }
    }
    
}
