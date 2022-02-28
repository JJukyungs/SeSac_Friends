//
//  HomeNearFriendViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/16.
//

import UIKit
import Tabman
import Pageboy
import CoreLocation


class HomeNearFriendViewController: UIViewController {
    
    let mainView = HomeNearFriendView()
    let viewModel = HomeViewModel.shared
    
    var fromQueueDB = [FromQueueDB]()
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
        nearSearchFriend()
        
        emptyViewChanged()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        
        
        // TableView configure
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.rowHeight = UITableView.automaticDimension
        
        
        mainView.changeHobbyButton.addTarget(self, action: #selector(changeHobbyButtonClicked), for: .touchUpInside)
        mainView.refreshButton.addTarget(self, action: #selector(refreshButtonClicked), for: .touchUpInside)
        
        
        mainView.tableView.register(BackgroundTableViewCell.self, forCellReuseIdentifier: BackgroundTableViewCell.identifier)
  
//        mainView.tableView.register(OtherProfileTableViewCell.self, forCellReuseIdentifier: OtherProfileTableViewCell.identifier)

        
        nearSearchFriend()
        emptyViewChanged()
        
    }

    func emptyViewChanged() {
        
        if viewModel.fillterResultDB.isEmpty {
            mainView.tableView.isHidden = true
            mainView.emptyView.isHidden = false
            mainView.changeHobbyButton.isHidden = false
            mainView.refreshButton.isHidden = false
        } else {
            mainView.tableView.isHidden = false
            mainView.emptyView.isHidden = true
            mainView.changeHobbyButton.isHidden = true
            mainView.refreshButton.isHidden = true
        }
    }
    
    func nearSearchFriend() {
        let searchModel = OnQueueModel(region: viewModel.centerRegion.value, lat: viewModel.centerLat.value, long: viewModel.centerLong.value)

        
        viewModel.searchFriends(model: searchModel) { OnQueueResult, statuscode, error in
            
            guard let OnQueueResult = OnQueueResult else {
                return
            }
            
            self.viewModel.fillterResultDB = OnQueueResult.fromQueueDB
            
            self.mainView.tableView.reloadData()
            print("------------------------")
            print(self.viewModel.fillterResultDB)
            print("------------------------")
        }
    }
    
    // MARK: - Action
    
    @objc func changeHobbyButtonClicked() {
        print(#function)
        
        QueueAPIService.deleteQueue(idToken: UserDefaults.standard.string(forKey: "idToken")!) { statuscode, error in
            
            switch statuscode {
            case HTTPStatusCode.SUCCESS.rawValue:
                
                // 취미화면 화면으로 이동
                self.navigationController?.popViewController(animated: true)
            
            // case 201, 406, 401  처리 해야함
            case DeleteQueue.ALREADY_MATCHING.rawValue:
                print(statuscode)
                self.view.makeToast("누군가와 취미를 함께하기로 약속하셨어요!")
                // 201 (GET, /queue/myQueueState) 호출 해야함
                
            case HTTPStatusCode.FIREBASE_TOKEN_ERROR.rawValue:
                self.updateIdToken { idToken, error in
                    self.changeHobbyButtonClicked()
                }
                
            default:
                print(statuscode)
            }
        }
    }
    
    @objc func refreshButtonClicked() {
        print(#function)
        
        let searchModel = OnQueueModel(region: HomeViewModel.shared.centerRegion.value, lat: HomeViewModel.shared.centerLat.value, long: HomeViewModel.shared.centerLong.value)
        
        viewModel.searchFriends(model: searchModel) { OnQueueModel, statuscode, error in
            
            // 페이지에 맞게 불러오기
            // 전에있던거 복 붙 ㄴㄴㄴ
            
        }
        
    }
    /*
    func nearFriendSearch() {
        
        let searchModel = OnQueueModel(region: viewModel.centerRegion.value, lat: viewModel.centerLat.value, long: viewModel.centerLong.value)
        
        viewModel.searchFriends(model: searchModel) { OnQueueResult, statusCode, error in
            
            guard let OnQueueResult = OnQueueResult else {
                return
            }
            
            OnQueueResult.fromQueueDB.forEach { otherUserInfo in
                
                
                
            }
            
            switch statusCode {
            case HTTPStatusCode.SUCCESS.rawValue:

                OnQueueResult.fromQueueDB.forEach { otherUserInfo in
                    
                    
                }
                
                
            case HTTPStatusCode.FIREBASE_TOKEN_ERROR.rawValue:
                
                self.updateIdToken { idToken, error in
                    
                    if let idToken = idToken {
                        self.nearFriendSearch()
                    }

                }
                
            default:
                print("server or client Error")

            }
            
        }
    }
    */
    
    
}

extension HomeNearFriendViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fillterResultDB.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 일단 임시용 데이터
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackgroundTableViewCell.identifier, for: indexPath) as? BackgroundTableViewCell else { return UITableViewCell() }
        
        cell.profileView.matchButton.backgroundColor = UIColor.errorColor
        
        cell.toggleView.titleLabel.text = viewModel.fillterResultDB[indexPath.row].nick
        
        
        return cell
        
        // 후에 구현해도 된다고한다...
        
        /*
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherProfileTableViewCell.identifier, for: indexPath) as? OtherProfileTableViewCell else { return UITableViewCell() }
        
        cell.contentView.isUserInteractionEnabled = false
        
        cell.otherProfileView.matchButton.backgroundColor = UIColor.errorColor
        
        cell.toggleView.titleLabel.text = viewModel.fillterResultDB[indexPath.row].nick
        
        cell.toggleButtonAction = {
            // 왜 여기서 두번 클릭해야 넘어갈까?
            cell.subView.isHidden = !cell.subView.isHidden
            print(cell.subView.isHidden)
            
            tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        
        return cell
         
         */
    }
    
    
}
