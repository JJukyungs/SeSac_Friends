//
//  CustomAnnoationView.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/02/10.
//

import Foundation
import MapKit

// 새싹 아이콘 얼굴을 쉽게 바꿀수 있게
enum sesacFaceImageType: String {
    case face1
    case face2
    case face3
    case face4
    case face5
}


// NSObject를 뒤에 쓰니깐 오류가 나오네?? 왜 나올까
// 코코종 블로그 참고
class CustomAnnotation: NSObject, MKAnnotation {
    
    let type: sesacFaceImageType
    let coordinate: CLLocationCoordinate2D
    
    init(type: sesacFaceImageType, coordinate: CLLocationCoordinate2D) {
        self.type = type
        self.coordinate = coordinate
        super.init()
    }
}

class CustomAnnotationView: MKAnnotationView {
    
    static let identifier = "CustomAnnotationView"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        frame = CGRect(x: 0, y: 0, width: 40, height: 50)
        centerOffset = CGPoint(x: 0, y: -frame.size.height/2)
        
        backgroundColor = .clear
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("CustomAnnotationView Error")
    }
}
