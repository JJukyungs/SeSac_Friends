//
//  OnBoardingViewController.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/20.
//

import UIKit

class OnBoardingViewControll: UIViewController {
    
    
    let boardingView = OnBoardingView()
    
    var slides: [OnBoardingSlide] = []
    
    var currentPage = 0
    
    override func loadView() {
        self.view = boardingView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray // 추후 삭제
        
        setCollcetionView()
        
        slides = [OnBoardingSlide(title: "위치 기반으로 빠르게  주위 친구를 확인", image: UIImage(named: "onboarding_img1")!), OnBoardingSlide(title: "관심사가 같은 친구를  찾을 수 있어요", image: UIImage(named: "onboarding_img2")!), OnBoardingSlide(title: "SeSAC Friends", image: UIImage(named: "Social life-cuate")!) ]
        boardingView.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        
        // rootView로 바꿔주기
        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: PhoneCertificationViewController())
            windowScene.windows.first?.makeKeyAndVisible()
        }
        
        // 추가해야할 거
        
        // UserDefault 이용해 온보드 안뜨게 하기
        
        
//        self.present(PhoneCertificationViewController(), animated: false)
    }
    
    func setCollcetionView() {
        
        boardingView.collectionView.delegate = self
        boardingView.collectionView.dataSource = self
        boardingView.collectionView.register(OnBoardingCollectionViewCell.self, forCellWithReuseIdentifier: OnBoardingCollectionViewCell.identifier)
    
    }
}

extension OnBoardingViewControll: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCollectionViewCell.identifier, for: indexPath) as? OnBoardingCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setup(slides[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        boardingView.pageControll.currentPage = currentPage
    }
    
}

