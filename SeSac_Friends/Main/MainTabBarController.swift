//
//  TapbarViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/27.
//

import UIKit
import SnapKit


class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = UIColor.greenColor
        self.tabBar.unselectedItemTintColor = .gray6Color
        self.tabBar.backgroundColor = .whiteColor
        
        setupTabBar()
    }
    
    func setupTabBar() {
        
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        homeViewController.tabBarItem.title = "홈"
        homeViewController.tabBarItem.image = UIImage(named: "homeInact")
        homeViewController.tabBarItem.selectedImage = UIImage(named: "homeAct")
        
        let shopViewController = UINavigationController(rootViewController: ShopViewController())
        shopViewController.tabBarItem.title = "새싹샵"
        shopViewController.tabBarItem.image = UIImage(named: "shopInact")
        shopViewController.tabBarItem.selectedImage = UIImage(named: "shopAct")
        
        let friendsViewController = UINavigationController(rootViewController: FriendsViewController())
        friendsViewController.tabBarItem.title = "새싹친구"
        friendsViewController.tabBarItem.image = UIImage(named: "friendsInact")
        friendsViewController.tabBarItem.selectedImage = UIImage(named: "friendsAct")
        
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        profileViewController.tabBarItem.title = "내정보"
        profileViewController.tabBarItem.image = UIImage(named: "myInact")
        profileViewController.tabBarItem.selectedImage = UIImage(named: "myAct")
        
        
        viewControllers = [homeViewController, shopViewController, friendsViewController, profileViewController]
    }
}
