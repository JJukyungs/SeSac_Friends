//
//  InputCertificationViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/23.
//

import UIKit
import Firebase
import FirebaseAuth
import Toast_Swift


class InputCertificatinoViewController: UIViewController {
    
    let mainView = InputCertificationView()
    

    
    
    var timer = 60
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 카운트 다운
        countDownTimer()
        
        view.backgroundColor = .white
        
        mainView.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        
        mainView.resendButton.addTarget(self, action: #selector(resendButtonClicked), for: .touchUpInside)
        
        mainView.certificationTextField.textfield.addTarget(self, action: #selector(certificationTextfieldChanged), for: .editingChanged)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 일정시간내 반복함수 종료
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        timer = 60
    }
    
    
    @objc func startButtonClicked() {
        print("startButton Click")
        
        print(LoginViewModel.shared.verificationCode)
        
        if LoginViewModel.shared.validCode(code: LoginViewModel.shared.verificationCode) == false {

            view.makeToast("6자리 인증번호를 입력해주세요")
            print("test33333")
            return
        }

        LoginViewModel.shared.checkCertificationCode { authResult, error in

            guard authResult != nil else {
                self.view.makeToast("전화번호 인증 실패")
                print("전화번호 인증 실패")
                return
            }

            if error != nil {
                print("check error: ", error!)
                self.view.makeToast("에러 발생, 잠시 후 다시 시도해주세요")
                return
            }

            print("인증번호 체크 완료!")


            // idToken 분기처리 해줘야함 [ 200, 201, 401 ]
            
            LoginViewModel.shared.getUserInfo { userInfo, error, statuscode in
                
                // API 호출 번호로 분기 처리
                switch statuscode {
                case 200:
                    self.view.makeToast("이미 가입된 회원입니다.")
                    print("200")
                case 406:
                    self.view.makeToast("휴대폰 번호 인증에 성공했습니다.")
                    print("406")
                case 401:
                    print("401")
                    Auth.auth().currentUser?.getIDTokenForcingRefresh(true) {
                        idToken, error in
                        
                        if let error = error {
                            self.view.makeToast("에러 발생. 다시 시도해주세요.")
                            return
                        }
                        
                        if let idToken = idToken {
                            print("idToken : ", idToken)
                            UserDefaults.standard.set(idToken, forKey: "idToken")
                        }
                        
                        
                    }
                default:
                    self.view.makeToast("에러코드 :  \(statuscode)")
                }
            }
            
            
            
            self.navigationController?.pushViewController(NickNameViewController(), animated: true)
        }
  
    }
    
    @objc func resendButtonClicked() {
        print("resendButton Click")
        
        
        let onlyPhoneNumber = LoginViewModel.shared.nohypenNumber.value
        print("onlyPhoneNumber :", onlyPhoneNumber)
        
        
        PhoneAuthProvider.provider().verifyPhoneNumber("+82 \(onlyPhoneNumber)", uiDelegate: nil) { verificationID, error in
            
            if let error = error {
                print("error : ", error.localizedDescription)
                return
            }
            
            UserDefaults.standard.set(verificationID, forKey: "AuthVerificationID")
            LoginViewModel.shared.verificationID = verificationID!
            self.timer = 60
        }
        
        view.makeToast("인증번호 재전송")

    }
    
    
    @objc func certificationTextfieldChanged() {
        
        LoginViewModel.shared.verificationCode = mainView.certificationTextField.textfield.text ?? ""
        
        if LoginViewModel.shared.validCode(code: LoginViewModel.shared.verificationCode) {
            mainView.certificationTextField.setupTfType(type: .succes)
            mainView.certificationTextField.subLabel.text = "유효한 형식입니다."
            mainView.startButton.setupBtType(type: .fill)
        
        } else {
            
            mainView.certificationTextField.setupTfType(type: .error)
            mainView.certificationTextField.subLabel.text = "잘못된 형식입니다."
            mainView.startButton.setupBtType(type: .disable)
            
        }
        
    }
    
    
    // timer 분으로 보이게
    func convertSecToTimer(sec: Int) {
        
        let minutes = (sec%3600)/60
        let seconds = (sec%3600)%60
        
        mainView.timerLabel.text = "\(minutes):\(String(format: "%02d", seconds))"
        
        if timer != 0 {
            perform(#selector(countDownTimer), with: nil, afterDelay: 1.0)
        } else {
            view.makeToast("인증 시간이 다 지났습니다.")
        }
    }
    
    
    @objc func countDownTimer() {
        convertSecToTimer(sec: timer)
        timer -= 1
    }
    

    
    
   
}
