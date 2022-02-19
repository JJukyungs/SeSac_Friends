//
//  HomeHobbyViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/13.
//

import UIKit



class HomeHobbyViewController: UIViewController {
    
    let mainView = HomeHobbyView()
    
    let viewModel = HomeViewModel.shared
    
  
    
//    // Keyboard ToolBar
//    let toolbar = UIToolbar()
//
//
//    let toolbarSearchButton: UIButton = {
//        let bt = UIButton()
//        bt.setTitle("새싹 찾기", for: .normal)
//        bt.setTitleColor(.whiteColor, for: .normal)
//        bt.backgroundColor = .greenColor
//        bt.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
//        return bt
//    }()
    
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 앞에 네비게이션바 숨긴게 따라옴
        view.backgroundColor = .white
        
        self.navigationItem.titleView = mainView.searchbar
       
        /*
        // toolbar 추가
        let toolbarButton = UIBarButtonItem.init(customView: toolbarSearchButton)
        toolbar.items = [toolbarButton]
        mainView.searchbar.searchTextField.inputAccessoryView = toolbar
        */
        
        
        mainView.hobbyCollectionView.dataSource = self
        mainView.hobbyCollectionView.delegate = self
        mainView.searchbar.searchTextField.delegate = self
        
        mainView.hobbyCollectionView.register(HomeHobbyCollectionCell.self, forCellWithReuseIdentifier: HomeHobbyCollectionCell.identifier)
        mainView.hobbyCollectionView.register(MyHobbyCollectionViewCell.self, forCellWithReuseIdentifier: MyHobbyCollectionViewCell.identifier)

        mainView.hobbyCollectionView.register(HobbyCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HobbyCollectionHeaderView.identifier)
    
        
        // searchButton
        mainView.searchButton.addTarget(self, action: #selector(searchFriends), for: .touchUpInside)
      
    }
    
    @objc func searchFriends() {
        print(#function)
        
        // 취미가 비어있을 경우 "Anything" 추가
        if viewModel.myHobbyArray.value.isEmpty {
            viewModel.myHobbyArray.value.append("Anything")
        }
        
        //postQueue Type 부분 항상 2로 요청
        let model = PostQueueModel(type: 2, region: viewModel.centerRegion.value, lat: viewModel.centerLat.value, long: viewModel.centerLong.value, hf: viewModel.myHobbyArray.value)
        
        print("model : ", model)
        
        viewModel.postQueue(model: model) { statuscode, error in
            
            guard let statuscode = statuscode else {
                return
            }
            print("statuscode : ", statuscode)
            
            
            
            // API 상태 코드 정리 후 다시 작성 예정
            
            switch statuscode {
                
            case HTTPStatusCode.SUCCESS.rawValue:
                self.navigationController?.pushViewController(HomeFriendTabManViewController(), animated: true)
                
            case HTTPStatusCode.FIREBASE_TOKEN_ERROR.rawValue:
                self.updateIdToken { idToken, error in
                    
                    if let idToken = idToken {
                        self.searchFriends()
                    }

                }
                
            case QueueSatusCode.ALREADY_THREE_REPORT.rawValue:
                self.view.makeToast("신고가 누적되어 이용하실 수 없습니다.")
            case QueueSatusCode.FIRST_PENALTY.rawValue:
                self.view.makeToast("약속 취소 패널티로, 1분동안 이용하실 수 없습니다")
            case QueueSatusCode.SECOND_PENALTY.rawValue:
                self.view.makeToast("약속 취소 패널티로, 2분동안 이용하실 수 없습니다")
            case QueueSatusCode.THIRD_PENALTY.rawValue:
                self.view.makeToast("연속으로 약속을 취소하셔서 3분동안 이용하실 수 없습니다")
            case QueueSatusCode.GENDER_NOT_SET.rawValue:
                self.view.makeToast("새싹 찾기 기능을 이용하기 위해서는 성별이 필요해요!")
            
                // 페이지 이동 기능 구현해야함
                
            default:
                print("statuscode: ",statuscode)
                print("좀만 기다려라.. 다시 온다")
            }
            
            
        }
        
        
        
    }
    
    
}

extension HomeHobbyViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            // 서비스에 추천 + 주변 친구 취미
            return viewModel.fromRecommendHobby.value.count + viewModel.nearByFriendsHobby.value.count
        }else {
            // test
            return viewModel.myHobbyArray.value.count
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            
            guard let hobbyCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeHobbyCollectionCell.identifier, for: indexPath) as? HomeHobbyCollectionCell else { return UICollectionViewCell() }
            
            if indexPath.item <= 3 {
                hobbyCell.tagLabel.text = viewModel.hobbyArray[indexPath.item]
                hobbyCell.tagLabel.textColor = .errorColor
                hobbyCell.cellView.layer.borderColor = UIColor.errorColor?.cgColor
            } else {
                hobbyCell.tagLabel.text = viewModel.hobbyArray[indexPath.item]
                hobbyCell.tagLabel.textColor = .blackColor
                hobbyCell.cellView.layer.borderColor = UIColor.gray4Color?.cgColor
            }
           
            
            return hobbyCell
            
        } else {
        
            guard let myHobbyCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyHobbyCollectionViewCell.identifier, for: indexPath) as? MyHobbyCollectionViewCell else { return UICollectionViewCell() }
            
            myHobbyCell.tagLabel.text = viewModel.myHobbyArray.value[indexPath.item]
            myHobbyCell.deleteHobbyAction = {
                if let index = self.viewModel.myHobbyArray.value.firstIndex(of: self.viewModel.myHobbyArray.value[indexPath.item]) {
                    
                    self.viewModel.myHobbyArray.value.remove(at: index)
                }
                
                self.mainView.hobbyCollectionView.reloadData()
               
            }
            return myHobbyCell
        
        }
        
       
        
        
    }
    
    // TableView Header랑 다르게 ReusableView로 구현됨
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            
            // section 분기처리 여기서
            
            if indexPath.section == 0 {
                
                guard let headerView = mainView.hobbyCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HobbyCollectionHeaderView.identifier, for: indexPath) as? HobbyCollectionHeaderView else { return UICollectionReusableView() }
                
                headerView.headerTitleLabel.text = "지금 주변에는"
                
                 return headerView
                
            } else {
                guard let headerView = mainView.hobbyCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HobbyCollectionHeaderView.identifier, for: indexPath) as? HobbyCollectionHeaderView else { return UICollectionReusableView() }
                
                headerView.headerTitleLabel.text = "내가 하고 싶은"
                
                 return headerView
                
            }
    
            
        default:
            assert(false)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 0 {
            let width: CGFloat = collectionView.frame.width
            let height: CGFloat = 30
            
            return CGSize(width: width, height: height)
        } else {
            let width: CGFloat = collectionView.frame.width
            let height: CGFloat = 50
            
            return CGSize(width: width, height: height)
        }
        
        

    }
    
    
}

extension HomeHobbyViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
           
            let textlabel: UILabel = {
                let label = UILabel()
                label.text = viewModel.hobbyArray[indexPath.item]
                label.font = UIFont.Title4_R14
                label.sizeToFit()
                return label
            }()
            let size = textlabel.frame.size
            
            return CGSize(width: size.width + 32, height: size.height + 10)
        } else {
            
            let textlabel: UILabel = {
                let label = UILabel()
                label.text = viewModel.myHobbyArray.value[indexPath.item]
                label.font = UIFont.Title4_R14
                label.sizeToFit()
                return label
            }()
            let size = textlabel.frame.size
            
            return CGSize(width: size.width + 52, height: size.height + 10)
        }
        
       
    }
    
    
}


// SearchBar Textfiled

extension HomeHobbyViewController: UITextFieldDelegate {
    
    // 키보드 return 입력시
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print(#function)
        
        textField.resignFirstResponder()
        
        guard let text = textField.text else { return true }
        
        // 띄어쓰기로 자르기
        let texts = text.split(separator: " ").map { String($0) }
        
        // 상태처리
        if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            
            self.view.makeToast("최소 한 자 이상, 최대 8글자까지 작성 가능합니다.")
            return true
        }
        
        // 8 개가 넘을 경우
        else if viewModel.myHobbyArray.value.count + texts.count > 8 {
            self.view.makeToast("취미를 더 이상 추가 할 수 없습니다. [최대 8개]")
            return true
        }
        
        // 태그 글자 수 8개 넘어가면 안됨
        for text in texts {
            
            if text.count > 8 {
                self.view.makeToast("최대 8 글자 까지 가능합니다.")
                return true
            }
            // 중복 취미 있나 확인
            else if viewModel.myHobbyArray.value.contains(text) {
                self.view.makeToast("이미 추가된 취미입니다.")
                return true
            }
        }
        
        viewModel.myHobbyArray.value += texts
        textField.text = ""
        
        mainView.hobbyCollectionView.reloadData()
        
        return true
        
        
    }
}
