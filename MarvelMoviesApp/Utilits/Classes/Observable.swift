//
//  Observable.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation

class Observable<T> {
    var value: T? {
        didSet{
            self.listener?(value)
        }
    }
    
    private var listener: ((T?) -> Void)?
    
    init (_ value:T?){
        self.value = value
    }
    
    func bind(_ listener: @escaping (T?) -> Void){
        listener (value)
        self.listener = listener
    }
}
