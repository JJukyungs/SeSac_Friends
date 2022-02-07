//
//  HomeViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/26.
//

import UIKit

class HomeViewController: UIViewController {

    let mainView = HomeView()
    
    
    override func loadView() {
        self.view = mainView
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
    }
    

    

}
