//
//  ProfileViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/27.
//

import UIKit

class ProfileViewController: UIViewController {

    let mainView = ProfileView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "내 정보"
        view.backgroundColor = .white
        
        setupTableView()
        
    }
    
    func setupTableView() {
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.tableView.register(ProfileHeaderTableViewCell.self, forCellReuseIdentifier: ProfileHeaderTableViewCell.identifier)
        mainView.tableView.register(NoticeTableViewCell.self, forCellReuseIdentifier: NoticeTableViewCell.identifier)
        
        mainView.tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    
  

}

// 섹션으로 나누어서 구현

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1 // section: 0 은 헤더뷰cell
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderTableViewCell.identifier, for: indexPath) as? ProfileHeaderTableViewCell else { return UITableViewCell() }
            
            // 임시 테스트 데이터
            cell.nameLable.text = "야야야야야야"
            
            return cell
        
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NoticeTableViewCell.identifier, for: indexPath) as? NoticeTableViewCell else { return UITableViewCell() }
            
            let row = indexPath.row
            
            
            cell.iconImage.image = UIImage(named: ProfileViewModel.shared.iconImageName[row])
            cell.noticeLabel.text = ProfileViewModel.shared.noticeTitle[row]
            
            
            return cell
        }
        
     
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = ProfileDetailVeiwController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
