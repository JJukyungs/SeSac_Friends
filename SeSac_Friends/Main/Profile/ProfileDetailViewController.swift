//
//  ProfileDetailViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/03.
//

import UIKit
import SnapKit
import RangeSeekSlider
import FirebaseAuth


class ProfileDetailVeiwController: UIViewController {
    
    let mainView = ProfileDetailView()
   
    
    
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ProfileViewModel.shared.userInfo.bind { userinfo in
            self.mainView.tableView.reloadData()
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
       
        title = "정보 관리"
        view.backgroundColor = .white
        
       
        setupTableView()
        
        let saveBarButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(saveBarButtonClicked))
        self.navigationItem.rightBarButtonItem = saveBarButton
        saveBarButton.tintColor = .blackColor
        
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
    
    
    @objc func saveBarButtonClicked() {
        
        
        let updateMypageModel = UpdateMyPageModel(searchable: ProfileViewModel.shared.searchable.value, ageMin: ProfileViewModel.shared.ageMin.value, ageMax: ProfileViewModel.shared.ageMax.value, gender: ProfileViewModel.shared.gender.value, hobby: ProfileViewModel.shared.hobby.value)
        
        print("입력 잘 왓나 확인 : ", updateMypageModel)
        
        ProfileViewModel.shared.updateMyPage(model: updateMypageModel) { statuscode in
            
            switch statuscode {
                
            case 200:
                self.view.makeToast("수정 완료")
            
            case 401:
                self.view.makeToast("토큰이 완료되어 갱신 중입니다.")
                
                Auth.auth().currentUser?.getIDTokenForcingRefresh(true) {
                    idToken, error in
                    
                    if let error = error {
                        self.view.makeToast("에러 발생. 다시 시도해주세요.")
                        return
                    }
                    
                    if let idToken = idToken {
                        print("idToken : ", idToken)
                        UserDefaults.standard.set(idToken, forKey: "idToken")
                    }
                }
                
            default:
                self.view.makeToast("수정 실패! 다시 시도해주세요")
                print("error code : ", statuscode)
            }
        }
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
                
            cell.contentView.isUserInteractionEnabled = false
            cell.selectionStyle = .none
            
            cell.toggleView.titleLabel.text = LoginViewModel.shared.nickname.value
            
            return cell
           
        
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GenderTableViewCell.identifier, for: indexPath) as? GenderTableViewCell else { return UITableViewCell() }
            
            // 이거 하나때문에 2시간을 태워????
            cell.contentView.isUserInteractionEnabled = false
            cell.selectionStyle = .none
            
            if ProfileViewModel.shared.gender.value != -1 {
                
                if ProfileViewModel.shared.gender.value == 0 {
                    cell.manButton.setupBtType(type: .inactive)
                    cell.womanButton.setupBtType(type: .fill)
                } else {
                    cell.manButton.setupBtType(type: .fill)
                    cell.womanButton.setupBtType(type: .inactive)
                }
                
            } else {
                cell.manButton.setupBtType(type: .inactive)
                cell.womanButton.setupBtType(type: .inactive)
            }
            
            cell.manButtonClickAction = {
                
                if ProfileViewModel.shared.gender.value != 1 {
                    ProfileViewModel.shared.gender.value = 1
                    
                    cell.manButton.setupBtType(type: .fill)
                    cell.womanButton.setupBtType(type: .inactive)
                }
            }
            
            cell.womanButtonClickAction = {
                
                if ProfileViewModel.shared.gender.value != 0 {
                    ProfileViewModel.shared.gender.value = 0
                    
                    cell.manButton.setupBtType(type: .inactive)
                    cell.womanButton.setupBtType(type: .fill)
                }
            }
            
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HobbyTableViewCell.identifier, for: indexPath) as? HobbyTableViewCell else { return UITableViewCell() }
                
            cell.contentView.isUserInteractionEnabled = false
            cell.selectionStyle = .none
            
            cell.hobbyTextfiledAction = {
                ProfileViewModel.shared.hobby.value = cell.hobbyTextfiled.textfield.text ?? ""
//                print(ProfileViewModel.shared.hobby.value)
            }
            
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhoneSearchValidTableViewCell.identifier, for: indexPath) as? PhoneSearchValidTableViewCell else { return UITableViewCell() }
            
            cell.contentView.isUserInteractionEnabled = false
            cell.selectionStyle = .none
            
            cell.searchValidSwitchAction = {
                if cell.validSwitch.isOn {
                    ProfileViewModel.shared.searchable.value = 1
                    print(ProfileViewModel.shared.searchable.value)
                } else {
                    ProfileViewModel.shared.searchable.value = 0
                    print(ProfileViewModel.shared.searchable.value)
                }
            }
            
            return cell
            
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AgeTableViewCell.identifier, for: indexPath) as? AgeTableViewCell else { return UITableViewCell() }
                
            cell.contentView.isUserInteractionEnabled = false
            cell.selectionStyle = .none
           
            cell.doubleSlider.delegate = self
            
            
            
            
            ProfileViewModel.shared.ageMin.bind { value in
                cell.changeLabel.text = "\(ProfileViewModel.shared.ageMin.value) - \(ProfileViewModel.shared.ageMax.value)"
            }
            
            ProfileViewModel.shared.ageMax.bind { value in
                cell.changeLabel.text = "\(ProfileViewModel.shared.ageMin.value) - \(ProfileViewModel.shared.ageMax.value)"
            }
            
//            cell.ageSliderAction = {
//                ProfileViewModel.shared.ageMin.value = Int(cell.doubleSlider.minValue)
//                ProfileViewModel.shared.ageMax.value = Int(cell.doubleSlider.maxValue)
//
//                print("minValue :", cell.doubleSlider.minValue)
//                print("maxValue :", cell.doubleSlider.maxValue)
                
//                cell.changeLabel.text = "\(ProfileViewModel.shared.ageMin.value) - \(ProfileViewModel.shared.ageMax.value)"
                
//            }
            
            return cell
            
        case 5:
            
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WithdrawTableViewCell.identifier, for: indexPath) as? WithdrawTableViewCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            // didselect에서 구현
            
            
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

extension ProfileDetailVeiwController: RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        
        ProfileViewModel.shared.ageMin.value = Int(minValue)
        ProfileViewModel.shared.ageMax.value = Int(maxValue)
        print(ProfileViewModel.shared.ageMin.value)
        print(ProfileViewModel.shared.ageMax.value)
    }
}
