//
//  HobbyTableViewCell.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/04.
//

import UIKit
import SnapKit

class HobbyTableViewCell: UITableViewCell {
    
    static let identifier = "HobbyTableViewCell"
    
    var hobbyTextfiledAction: (() -> ())?
    
    lazy var hobbyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Title4_R14
        label.textColor = .blackColor
        label.text = "자주 하는 취미"
        return label
    }()
    
    
    lazy var hobbyTextfiled: CustomTextField = {
        let tf = CustomTextField(frame: .zero, type: .inactive)
        tf.textfield.placeholder = "취미를 입력해 주세요"
        tf.textfield.font = UIFont.Title4_R14
        tf.textfield.textColor = .blackColor
        return tf
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
        
        self.hobbyTextfiled.textfield.addTarget(self, action: #selector(hobbyTextfieldValueChange), for: .editingChanged)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    @objc func hobbyTextfieldValueChange() {
        print("hobbyTextfieldValueChange")
        hobbyTextfiledAction?()
    }
    
    func setupView() {
        addSubview(hobbyLabel)
        addSubview(hobbyTextfiled)
        
    }
    
    func setupConstraints() {
        
        hobbyLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(13)
        }
        
        hobbyTextfiled.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(164)
            make.height.equalTo(48)
        }
        
    }
}
