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
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
