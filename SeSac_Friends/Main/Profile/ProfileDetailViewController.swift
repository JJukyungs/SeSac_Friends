//
//  ProfileDetailViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/03.
//

import UIKit
import SnapKit


class ProfileDetailVeiwController: UIViewController {
    
    let mainView = ProfileDetailView()
   
    
    
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            ProfileViewModel.shared.getUserInfo { userinfo, error, statuscode in
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ProfileDetailView Start")
        DispatchQueue.main.async {
            
            ProfileViewModel.shared.getUserInfo { userinfo, error, statuscode in
            }
        }
        
        ProfileViewModel.shared.userInfo.bind { userinfo in
            ProfileViewModel.shared.updateData()
            self.mainView.tableView.reloadData()
        }
        print("ViewDidLoad : ", ProfileViewModel.shared.userInfo.value)
        print("Gender : ", ProfileViewModel.shared.gender.value)
        
        title = "정보 관리"
        view.backgroundColor = .white
        
        print("----------")
        print(ProfileViewModel.shared.userInfo.value.nick)
        print("----------")
        
        setupTableView()
    }
    
    func setupTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
//        mainView.tableView.isUserInteractionEnabled = true
        
        mainView.tableView.rowHeight = UITableView.automaticDimension
        mainView.tableView.estimatedRowHeight = 500
        
        mainView.tableView.register(BackgroundTableViewCell.self, forCellReuseIdentifier: BackgroundTableViewCell.identifier)
        
        mainView.tableView.register(GenderTableViewCell.self, forCellReuseIdentifier: GenderTableViewCell.identifier)
        
        mainView.tableView.register(HobbyTableViewCell.self, forCellReuseIdentifier: HobbyTableViewCell.identifier)
        
        mainView.tableView.register(PhoneSearchValidTableViewCell.self, forCellReuseIdentifier: PhoneSearchValidTableViewCell.identifier)
        
        mainView.tableView.register(AgeTableViewCell.self, forCellReuseIdentifier: AgeTableViewCell.identifier)
       
        mainView.tableView.register(WithdrawTableViewCell.self, forCellReuseIdentifier: WithdrawTableViewCell.identifier)
    }
    
    
}

extension ProfileDetailVeiwController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // 임시
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        switch indexPath.section {
            
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BackgroundTableViewCell.identifier, for: indexPath) as? BackgroundTableViewCell else { return UITableViewCell() }
                
            cell.toggleView.titleLabel.text = LoginViewModel.shared.nickname.value
            
            return cell
           
        
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GenderTableViewCell.identifier, for: indexPath) as? GenderTableViewCell else { return UITableViewCell() }
            
            // 이거 하나때문에 2시간을 태워????
            cell.contentView.isUserInteractionEnabled = false
            
            if ProfileViewModel.shared.gender.value != -1 {
                
                if ProfileViewModel.shared.gender.value == 0 {
                    cell.manButton.setupBtType(type: .inactive)
                    cell.womanButton.setupBtType(type: .fill)
                } else {
                    cell.manButton.setupBtType(type: .fill)
                    cell.womanButton.setupBtType(type: .inactive)
                }
                
            }
            
            cell.manButtonClickAction = {
                print("cell manButton Click")
            }
            
            cell.womanButtonClickAction = {
                print("cell womanButton Click")
            }
            
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HobbyTableViewCell.identifier, for: indexPath) as? HobbyTableViewCell else { return UITableViewCell() }
                
            cell.contentView.isUserInteractionEnabled = false
            
            cell.hobbyTextfiledAction = {
                ProfileViewModel.shared.hobby.value = cell.hobbyTextfiled.textfield.text ?? ""
                print(ProfileViewModel.shared.hobby.value)
            }
            
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhoneSearchValidTableViewCell.identifier, for: indexPath) as? PhoneSearchValidTableViewCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            
            return cell
            
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AgeTableViewCell.identifier, for: indexPath) as? AgeTableViewCell else { return UITableViewCell() }
                
           
            
            return cell
            
        case 5:
            
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WithdrawTableViewCell.identifier, for: indexPath) as? WithdrawTableViewCell else { return UITableViewCell() }
                
            
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.section)
        
        if indexPath.section == 5 {
            print("Alert")
        }
        
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
