//
//  BirthdayViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/23.
//

import UIKit


class BirthdayViewController: UIViewController {
    
    let mainView = BirthdayView()
    
    let datePicker = UIDatePicker()
    
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    
        createDatePicker()
        
        mainView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        
    }
    
    
    @objc func nextButtonClicked() {
        print("birth buttonclick")
        
        navigationController?.pushViewController(EmailViewController(), animated: true)
    }
    
    
    func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.maximumDate = Date() // 최대값을 현재 시간으로
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        mainView.yearTexfield.textfield.inputView = datePicker
        mainView.monthTexfield.textfield.inputView = datePicker
        mainView.dayTexfield.textfield.inputView = datePicker
        
        
    }
    
    
    
    @objc func datePickerValueChanged(_ datePicker: UIDatePicker) {
        
        LoginViewModel.shared.birthday.value = datePicker.date
        
        let formmater = DateFormatter()
        
        formmater.dateFormat = "yyyy"
        mainView.yearTexfield.textfield.text = formmater.string(from: datePicker.date)
        print("yyyy : ",datePicker.date)
        
        formmater.dateFormat = "MM"
        mainView.monthTexfield.textfield.text = formmater.string(from: datePicker.date)
        print("MM : ", datePicker.date)
        
        formmater.dateFormat = "dd"
        mainView.dayTexfield.textfield.text = formmater.string(from: datePicker.date)
        print("dd : ", datePicker.date)
        
        
        if westernAge() >= 17 {
            print("만 17세 이상") // 작동 확인 완료
            
            mainView.yearTexfield.setupTfType(type: .succes)
            mainView.monthTexfield.setupTfType(type: .succes)
            mainView.dayTexfield.setupTfType(type: .succes)
            mainView.nextButton.setupBtType(type: .fill)
        } else {
            print("만 17세 이하")
            
            mainView.yearTexfield.setupTfType(type: .error)
            mainView.monthTexfield.setupTfType(type: .error)
            mainView.dayTexfield.setupTfType(type: .error)
            mainView.nextButton.setupBtType(type: .disable)
            
            view.makeToast("새싹친구들은 만17세 이상부터 사용이 가능합니다.")
        }
        
        
    }
    
    // 만 나이 계산
    func westernAge() -> Int {
        let westernage = Calendar.current.dateComponents([.year], from: LoginViewModel.shared.birthday.value, to: Date.now).year ?? 0
    
        return westernage
    }
}
