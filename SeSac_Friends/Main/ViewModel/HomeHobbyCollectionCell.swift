//
//  HomeHobbyCollectionCell.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/13.
//

import UIKit
import SnapKit


class HomeHobbyCollectionCell: UICollectionViewCell {
    
    static let identifier = "HomeHobbyCollectionCell"

    
    let cellView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        return view
    }()
    
    let tagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Title4_R14
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(cellView)
        cellView.addSubview(tagLabel)
        
    }
    
    func setupConstraints() {
        
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tagLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(cellView).inset(5)
            make.leading.trailing.equalTo(cellView).inset(16)
        }
    }
    
}
