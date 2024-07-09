//
//  Observable.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/9/24.
//

import Foundation

class Observable<T> {
    private var closure: ((T) -> Void)?
    
    var value: T {
        didSet { closure?(value) }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> Void) {
        closure(value)
        self.closure = closure
    }
}
