//
//  Observable.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/23.
//

import Foundation

// Rx 사용하기 전까지 일단 옵저버블 사용
class Observable<T> {
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
