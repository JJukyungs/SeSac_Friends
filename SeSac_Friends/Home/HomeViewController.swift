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
