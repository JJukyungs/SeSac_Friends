//
//  HomeViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/26.
//

import UIKit
import MapKit
import CoreLocation
import Toast_Swift

class HomeViewController: UIViewController {

    let mainView = HomeView()
    
    let locationManager = CLLocationManager()
    var myLocation: CLLocation!
    
    let campusCoordinate = CLLocationCoordinate2DMake(37.517819364682694, 126.88647317074734)
    // 시뮬레이터 좌표 새싹 캠퍼스로 고정해놓았음... 후에 수정 및
    
    override func loadView() {
        self.view = mainView
        
    }
    
    // 화면 이동시 계속 호출 될수 있게?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)

        monitorNetwork()
        
        HomeViewModel.shared.getUserInfo { userinfo, error, statuscode in
            
            guard let userinfo = userinfo else {
                return
            }
            
        }
        
        searchFirends()
        
        // 플로팅 버튼 상태처리도 구현해야함
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)

        view.backgroundColor = .white
        
        locationManager.delegate = self
        mainView.mapView.delegate = self
        
        setupLocation()
        
        navigationController?.navigationBar.isHidden = true
        
        // Button Action
        mainView.manButton.addTarget(self, action: #selector(filterButtonClicked(sender: )), for: .touchUpInside)
        mainView.womanButton.addTarget(self, action: #selector(filterButtonClicked(sender:)), for: .touchUpInside)
        mainView.allButton.addTarget(self, action: #selector(filterButtonClicked(sender:)), for: .touchUpInside)
        mainView.gpsButton.addTarget(self, action: #selector(gpsButtonClicked), for: .touchUpInside)
    }
    
    // MARK: - ButtonClickAction
    // allButton이 클릭이 잘 안된다.
    // 갓 박연배님 말 참고해보니 네비게이션 바에 가려져서 제대로 안눌리는 현상이 있엇음 . 연배님 해결 -> 네비 바 히든 처리
    
    @objc func filterButtonClicked(sender: CustomButton) {
        print(#function)

        sender.layer.borderWidth = 0
        
        switch sender.tag {
        case 0:
            mainView.womanButton.setupBtType(type: .fill)
            mainView.manButton.setupBtType(type: .inactive)
            mainView.allButton.setupBtType(type: .inactive)
        case 1:
            mainView.womanButton.setupBtType(type: .inactive)
            mainView.manButton.setupBtType(type: .fill)
            mainView.allButton.setupBtType(type: .inactive)

        case 2:
            mainView.womanButton.setupBtType(type: .inactive)
            mainView.manButton.setupBtType(type: .inactive)
            mainView.allButton.setupBtType(type: .fill)
            

            
        default:
            view.makeToast("다시 한번 클릭해주세요")
        }
        
        HomeViewModel.shared.genderFilter.value = sender.tag
        print(HomeViewModel.shared.genderFilter.value)
        
        searchFirends()
    }
    

    @objc func gpsButtonClicked() {
        print(#function)

        guard let currentLocation = locationManager.location else {
            locationManager.requestWhenInUseAuthorization()
            settingAlert()
            return
        }
        
        myLocation = currentLocation
        
        mainView.mapView.showsUserLocation = true
        mainView.mapView.setUserTrackingMode(.follow, animated: true)
        
        searchFirends()

    }

    
    // MARK: - Location
    
    func setupLocation() {
        print(#function)

        checkUserLocationServiceAuthorization()
        
        myLocation = locationManager.location
        
        mainView.mapView.setRegion(MKCoordinateRegion(center: campusCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        
//        addPin()
    }
    
//    // Pin 추가
//    func addPin() {
//        let pin = MKPointAnnotation()
//        pin.coordinate = campusCoordinate
//        mainView.mapView.addAnnotation(pin)
//    }
    
    
    // Filter -> Gender 값에 따라 보여주게
    func addFilterPin(genderFilter: Int) {
        print(#function)

        mainView.mapView.removeAnnotations(mainView.mapView.annotations)
        
        
        if genderFilter == 2 {
            mainView.mapView.addAnnotations(HomeViewModel.shared.manAnnotation)
            mainView.mapView.addAnnotations(HomeViewModel.shared.womanAnnotation)
        } else {
            if genderFilter == 0 {
                mainView.mapView.addAnnotations(HomeViewModel.shared.womanAnnotation)
            } else {
                mainView.mapView.addAnnotations(HomeViewModel.shared.manAnnotation)
            }
        }
        
    }
    
    
    
}

// 016회차 파일 [트랜드미디어], 마늘맨 블로그 참조

extension HomeViewController: CLLocationManagerDelegate {
    
    // 사용자 권한 상태 확인
    func checkCurrentLocationAuthorization(_ authorizationStatus : CLAuthorizationStatus){
        print(#function)

        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정말 리얼리스트 하게 자세하게 위치를 잡기
            locationManager.requestWhenInUseAuthorization() // 앱을 사용하는 동안 에 대한 위치 권한 요청
            locationManager.startUpdatingLocation() // 위치 접근 시작 => didUpdateLocaitons 실행
        case .restricted, .denied:
            settingAlert()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation() // 위치 접근 시작 => didUpdateLocaitons 실행
        @unknown default:
            print("DEFAULT")
        }
        
        if #available(iOS 14.0, *) {
            // 정확도 체크 : 정확도 감소가 되어 있을 경우, 1시간 4번, 미리 알림, 배터리 오래 쓸수있음, 워치 랑 동기화
            let accurancyState = locationManager.accuracyAuthorization
            
            switch accurancyState {
            case .fullAccuracy:
                print("Full")
            case .reducedAccuracy:
                print("Reduce")
            @unknown default:
                print("Default")
            }
        }
        
    }
    
    // 9. iOS 버전에 따른 분기 처리와 iOS 위치 서비스 여부 확인
    func checkUserLocationServiceAuthorization() {
        print(#function)

        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus // iOS 14 이상에서만 사용가능
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus() // 열거형, iOS 14 미만

        }
        
        // iOS 위치 서비스 확인
        if CLLocationManager.locationServicesEnabled() {
            
            // 권한 상태 확인 및 권한 요청 기능 (8번 메서드 실행)
            checkCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("iOS 위치 서비스를 켜주세요")
        }
    }
    
    // 권한이 변경될 때 마다 감지해서 실행
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserLocationServiceAuthorization()

    }
    
    // 위치 접근에 실패한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERROR")
        
    }
    
    // 사용자가 위치 허용을 한 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)

        //guard let location = locations.last else { return }
        
        if let coordinate = locations.last?.coordinate {
            
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            
        
            mainView.mapView.setRegion(region, animated: true)
                
                
//            allAnnotations()
            locationManager.stopUpdatingLocation()
        
        }
    }
    
    // 설정페이지로 가기 위한 얼럿
    func settingAlert() {
        print(#function)

        let alert = UIAlertController(title: "위치 권한 설정 요청", message: "새싹 친구들을 검색하기 위해 위치 권한을 설정해주세요", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "설정", style: .default) { alertAction in
            
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    /*
     fromQueueDB : Object  - 다른 사용자 목록
     fromQueueDBRequested : Object - 나에게 ‘요청한’ 다른 사용자의 목록
     그 외 기획서 참고..
     */
    
    func searchFirends() {
        
        print(#function)
        
        let searchModel = OnQueueModel(region: HomeViewModel.shared.centerRegion.value, lat: HomeViewModel.shared.centerLat.value, long: HomeViewModel.shared.centerLong.value)
        
        
        HomeViewModel.shared.searchFriends(model: searchModel) { onqueueresult, statuscode, error in
            
            guard let onqueueresult = onqueueresult else {
                return
            }
            HomeViewModel.shared.womanAnnotation.removeAll()
            HomeViewModel.shared.manAnnotation.removeAll()
            
            switch statuscode {
            
            case 200:
                
                
                // 다른 사용자 목록
                onqueueresult.fromQueueDB.forEach { otherUserInfo in
                    
                    switch otherUserInfo.gender {
                        
                    case 0:
                        HomeViewModel.shared.womanAnnotation.append(CustomAnnotation(type: HomeViewModel.shared.setupSesacFaceImageType(sesac: otherUserInfo.sesac), coordinate: CLLocationCoordinate2D(latitude: otherUserInfo.lat, longitude: otherUserInfo.long)))
                    
                    case 1:
                        HomeViewModel.shared.manAnnotation.append(CustomAnnotation(type: HomeViewModel.shared.setupSesacFaceImageType(sesac: otherUserInfo.sesac), coordinate: CLLocationCoordinate2D(latitude: otherUserInfo.lat, longitude: otherUserInfo.long)))
                    default:
                        self.view.makeToast("error")
                        print("HomeViewController 301.p")
                    }
                }
                
                // 나에게 요청한 목록은 나중에
                
                self.addFilterPin(genderFilter: HomeViewModel.shared.genderFilter.value)
                
            case 401:
                print("Firebase Token Error")
            case 406:
                print("미가입 회원")
            default:
                print("server or client Error")
            }
            
            
        }
    }
    
    
}

extension HomeViewController: MKMapViewDelegate {
    
    // 지도 이동
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        let lat = mainView.mapView.centerCoordinate.latitude
        let long = mainView.mapView.centerCoordinate.longitude
        
        HomeViewModel.shared.setRegion(lat: lat, long: long)
        
        searchFirends()
    }
    
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        

        guard let annotation = annotation as? CustomAnnotation else {
            return nil
        }

        var annotationView = self.mainView.mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.identifier)
            annotationView?.canShowCallout = false
            annotationView?.contentMode = .scaleAspectFill
        
        } else {
            annotationView?.annotation = annotation
        }
        
        let sesacFaceImage: UIImage!
        let size = CGSize(width: 85, height: 85)
        
        UIGraphicsBeginImageContext(size)
        
        
        switch annotation.type {
            
        case .face1:
            sesacFaceImage = UIImage(named: "sesac_face_1")
        case .face2:
            sesacFaceImage = UIImage(named: "sesac_face_2")
        case .face3:
            sesacFaceImage = UIImage(named: "sesac_face_3")
        case .face4:
            sesacFaceImage = UIImage(named: "sesac_face_4")
        case .face5:
            sesacFaceImage = UIImage(named: "sesac_face_5")
        }
        
        sesacFaceImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        annotationView?.image = resizeImage
        
        return annotationView
        
    }
}
