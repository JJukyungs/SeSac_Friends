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
    let tagList: [String] = ["test", "testest", "testttt", "asdad"]
    
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
    }
    
    
}

extension HomeHobbyViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        if section == 0 {
//            //test
//            return 4
//        }else {
//            // test
//            return 2
//        }
        
        // test
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /*
        if indexPath.section == 0 {
            
        
            
        }
        */
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeHobbyCollectionCell.identifier, for: indexPath) as? HomeHobbyCollectionCell else { return UICollectionViewCell() }
        
        cell.tagLabel.text = tagList[indexPath.item]
        
        return cell
        
        
    }
    
    
}


