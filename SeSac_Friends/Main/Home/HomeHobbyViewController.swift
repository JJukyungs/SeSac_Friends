//
//  HomeHobbyViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/13.
//

import UIKit



class HomeHobbyViewController: UIViewController {
    
    let mainView = HomeHobbyView()
    
    
    // test용
    let tagList: [String] = ["test", "testestㅁㄴㅇㄹㅁㄴㄹㅁㄴㄹㅁㄴㄹ", "testttt", "asdadㄴㅇㄹㄴㄹㄴㅁㅇㄹㅁㄴ"]
    
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
        
        
        mainView.hobbyCollectionView.dataSource = self
        mainView.hobbyCollectionView.delegate = self
        
        mainView.hobbyCollectionView.register(HomeHobbyCollectionCell.self, forCellWithReuseIdentifier: HomeHobbyCollectionCell.identifier)
        mainView.hobbyCollectionView.register(MyHobbyCollectionViewCell.self, forCellWithReuseIdentifier: MyHobbyCollectionViewCell.identifier)

        mainView.hobbyCollectionView.register(HobbyCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HobbyCollectionHeaderView.identifier)
        
    }
    
    
    
}

extension HomeHobbyViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            // 서비스에 추천 + 주변 친구 취미
            return HomeViewModel.shared.fromRecommendHobby.value.count + HomeViewModel.shared.nearByFriendsHobby.value.count
        }else {
            // test
            return 4
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            
            guard let hobbyCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeHobbyCollectionCell.identifier, for: indexPath) as? HomeHobbyCollectionCell else { return UICollectionViewCell() }
            
            if indexPath.item > 3 {
                hobbyCell.tagLabel.text = HomeViewModel.shared.hobbyArray[indexPath.item]
                hobbyCell.tagLabel.textColor = .errorColor
                hobbyCell.cellView.layer.borderColor = UIColor.errorColor?.cgColor
            } else {
                hobbyCell.tagLabel.text = HomeViewModel.shared.hobbyArray[indexPath.item]
                hobbyCell.tagLabel.textColor = .blackColor
                hobbyCell.cellView.layer.borderColor = UIColor.gray4Color?.cgColor
            }
           
            
            return hobbyCell
            
        } else {
        
            guard let myHobbyCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyHobbyCollectionViewCell.identifier, for: indexPath) as? MyHobbyCollectionViewCell else { return UICollectionViewCell() }
            
            myHobbyCell.tagLabel.text = tagList[indexPath.item]
            
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
                label.text = tagList[indexPath.item]
                label.font = UIFont.Title4_R14
                label.sizeToFit()
                return label
            }()
            let size = textlabel.frame.size
            
            return CGSize(width: size.width + 32, height: size.height + 10)
        } else {
            
            let textlabel: UILabel = {
                let label = UILabel()
                label.text = tagList[indexPath.item]
                label.font = UIFont.Title4_R14
                label.sizeToFit()
                return label
            }()
            let size = textlabel.frame.size
            
            return CGSize(width: size.width + 48, height: size.height + 10)
        }
        
       
    }
    
    
}


