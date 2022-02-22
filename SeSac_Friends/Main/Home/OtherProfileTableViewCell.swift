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
    
    
    lazy var otherProfileView: ProfileView = {
        let view = ProfileView(frame: .zero)
        
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
