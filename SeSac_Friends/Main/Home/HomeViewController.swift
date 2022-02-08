//
//  HomeViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/26.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController {

    let mainView = HomeView()
    
    let locationManager = CLLocationManager()
    
    override func loadView() {
        self.view = mainView
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        locationManager.delegate = self
        mainView.mapView.delegate = self
        
    }
    
    // MARK: - ButtonClickAction
    
    @objc func floatingButtonClicked() {
        
    }
    
    @objc func manButtonClicked() {
        
    }
    
    @objc func womanButtonClicked() {
        
    }
    
    @objc func allButtonClicked() {
        
    }


}

// 016회차 파일 [트랜드미디어], 마늘맨 블로그 참조

extension HomeViewController: CLLocationManagerDelegate {
    
    // 사용자 권한 상태 확인
    func checkCurrentLocationAuthorization(_ authorizationStatus : CLAuthorizationStatus){
        
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정말 리얼리스트 하게 자세하게 위치를 잡기
            locationManager.requestWhenInUseAuthorization() // 앱을 사용하는 동안 에 대한 위치 권한 요청
            locationManager.startUpdatingLocation() // 위치 접근 시작 => didUpdateLocaitons 실행
        case .restricted, .denied:
            print("DENIED, 설정으로 유도")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation() // 위치 접근 시작 => didUpdateLocaitons 실행
        case .authorizedAlways:
            print("Always")
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
        
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus =         locationManager.authorizationStatus // iOS 14 이상에서만 사용가능
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
        // MARK: - 해결해야할 부분
        // 지금 위치 접근에 실패를 함 위치접근할수 있게 해야함
    }
    
    // 사용자가 위치 허용을 한 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //guard let location = locations.last else { return }
        
        if let coordinate = locations.last?.coordinate {
            
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            
        
            mainView.mapView.setRegion(region, animated: true)
                
                
//            allAnnotations()
            locationManager.stopUpdatingLocation()
        
        }
    }
    
    
}

extension HomeViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return nil
    }
}
