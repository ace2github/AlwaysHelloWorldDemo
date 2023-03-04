//
//  RXManager.swift
//  SwiftUIHelloWorld
//
//  Created by chaohui chen on 2022/12/1.
//

import Foundation
import RxSwift

func testRx() {
    let numbers: Observable<Int> = Observable.create { observer -> Disposable in
        for i in 0...10 {
            observer.onNext(i)
        }
        observer.onCompleted()
        return Disposables.create()
    }
    
    let dispose :Disposable = numbers.subscribe { num in
        print(num)
    } onError: { err in
        print(err)
    } onCompleted: {
        print("finish!")
    } onDisposed: {
        print("disposed")
    }
    dispose.dispose()
}
