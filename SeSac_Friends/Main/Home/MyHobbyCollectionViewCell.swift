//
//  MyHobbyCollectionViewCell.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/14.
//

import UIKit
import SnapKit


class MyHobbyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MyHobbyCollectionViewCell"
    
    var deleteHobbyAction: (() -> ())?
    
    let cellView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.greenColor?.cgColor
        return view
    }()
    
    let tagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Title4_R14
        label.textColor = .greenColor
        return label
    }()
    
    let closeButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "xmark"), for: .normal)
        bt.tintColor = .greenColor
        return bt
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
        
        self.closeButton.addTarget(self, action: #selector(deleteMyHobbyButtonClicked), for: .touchUpInside)
    }
    
    @objc func deleteMyHobbyButtonClicked() {
        print(#function)
        deleteHobbyAction?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        addSubview(cellView)
        cellView.addSubview(tagLabel)
        cellView.addSubview(closeButton)
    }
    
    func setupConstraints() {
        
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tagLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(cellView).inset(5)
            make.leading.equalTo(cellView).inset(16)
        }
        
        closeButton.snp.makeConstraints { make in
            make.leading.equalTo(tagLabel.snp.trailing).offset(4)
            make.trailing.equalTo(cellView).inset(16)
            make.top.bottom.equalTo(cellView).inset(5)
        }
    }
    
    
    
    
}
