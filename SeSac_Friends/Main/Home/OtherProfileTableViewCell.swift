//
//  OtherProfileTableViewCell.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/22.
//

import UIKit
import SnapKit


class OtherProfileTableViewCell: UITableViewCell {
    
    static let identifier = "OtherProfileTableViewCell"
    
    var toggleButtonAction: (() -> ())?
    var requestButtonAction: (() -> ())?
    
    
    lazy var otherProfileView: ProfileImageView = {
        let view = ProfileImageView(frame: .zero)
        view.backgroundImage.image = UIImage(named: "sesac_bg_01")
        view.sesacFaceImage.image = UIImage(named: "sesac_face_2")
        return view
    }()
    
    
    
    lazy var stackview: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = .whiteColor
        stack.distribution = .fill
        stack.layer.borderWidth = 1
        stack.layer.borderColor = UIColor.gray4Color?.cgColor
        stack.layer.cornerRadius = 8

        return stack
    }()
    
    // StackView 안에 들어갈 요소들
    
    lazy var toggleView: ToggleView = {
        let view = ToggleView(frame: .zero)
        view.titleLabel.text = "testestest"

        return view
    }()
    
    
    var subView = UIView()
    {
        didSet {
            subView.isHidden = true
        }
    }
    
    let sesacTitle: UILabel = {
        let label = UILabel()
        label.text = "새싹 타이틀"
        label.font = UIFont.Title6_R12
        return label
    }()
    
    let requtationView = ReputationView()
    
    
    let hobbyTitle: UILabel = {
        let label = UILabel()
        label.text = "하고 싶은 취미"
        label.font = UIFont.Title6_R12
        return label
    }()
    
    // 취미 컬렉션 뷰
    let otherUserHobbyCollectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.isScrollEnabled = false
        collectionView.collectionViewLayout = layout
        return collectionView
    }()
    
    let reviewTitle: UILabel = {
        let label = UILabel()
        label.text = "새싹 리뷰"
        label.font = UIFont.Title6_R12
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    
        toggleView.arrowButton.addTarget(self, action: #selector(toggleButtonClicked), for: .touchUpInside)
        
        otherUserHobbyCollectionView.dataSource = self
        otherUserHobbyCollectionView.delegate = self
        
        // HomeHobbyCollectionCell 재사용
        otherUserHobbyCollectionView.register(HomeHobbyCollectionCell.self, forCellWithReuseIdentifier: HomeHobbyCollectionCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggleButtonClicked() {
        toggleButtonAction?()
    }
    
    func setupView() {
        addSubview(otherProfileView)
        addSubview(stackview)
        stackview.addArrangedSubview(toggleView)
        stackview.addArrangedSubview(subView)
        subView.addSubview(sesacTitle)
        subView.addSubview(requtationView)
        subView.addSubview(hobbyTitle)
        subView.addSubview(otherUserHobbyCollectionView)
        subView.addSubview(reviewTitle)
        
    }
    
    func setupConstraints() {
        
        otherProfileView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(stackview.snp.top)
            make.height.equalTo(194)
        }
        stackview.snp.makeConstraints { make in
            make.top.equalTo(otherProfileView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        toggleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        subView.snp.makeConstraints { make in
            make.top.equalTo(toggleView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        sesacTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }
        requtationView.snp.makeConstraints { make in
            make.top.equalTo(sesacTitle.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
//            make.height.equalTo(112)
            make.bottom.equalTo(hobbyTitle.snp.top).offset(-16)
        }
        hobbyTitle.snp.makeConstraints { make in
            make.top.equalTo(requtationView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }
        otherUserHobbyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(hobbyTitle.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
//            make.bottom.equalTo(reviewTitle.snp.top)
            make.height.equalTo(150)
        }
        reviewTitle.snp.makeConstraints { make in
            make.top.equalTo(otherUserHobbyCollectionView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
//            make.bottom.equalToSuperview()
            make.height.equalTo(18)
        }
    }
}


extension OtherProfileTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       return 3
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
      
        guard let hobbyCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeHobbyCollectionCell.identifier, for: indexPath) as? HomeHobbyCollectionCell else { return UICollectionViewCell() }
            
        hobbyCell.tagLabel.text = "testest"
           
            
        return hobbyCell
            
        
    }
    
   
    
    
   
    
    
    
    
}


extension OtherProfileTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let textlabel: UILabel = {
            let label = UILabel()
//            label.text = viewModel.myHobbyArray.value[indexPath.item]
            label.text = "testest"
            label.font = UIFont.Title4_R14
            label.sizeToFit()
            return label
        }()
        let size = textlabel.frame.size
        
        return CGSize(width: size.width + 32, height: size.height + 10)
       
    }
    
    
}
