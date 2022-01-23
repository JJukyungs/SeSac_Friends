//
//  GenderViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/24.
//

import UIKit


class GenderViewController: UIViewController {
    
    let mainView = GenderView()
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
}
