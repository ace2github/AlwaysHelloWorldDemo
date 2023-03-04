//
//  EBBus.swift
//  SwiftUIHelloWorld
//
//  Created by chaohui chen on 2022/12/2.
//

import Foundation

public class EBBus : NSObject {
    var _observerPool: Dictionary<String, EBObserver> = [:]
}

protocol EBBusOperator {
    func register(_ key: String, _ subscribe: @escaping EBAction)
    
    func unregister(_ key: String)
    
    func emit(_ key: String, _ arg: Any?)
}

extension EBBus : EBBusOperator {
    func register(_ key: String, _ subscribe: @escaping EBAction) {
        var ob = _observerPool[key]
        if ob == nil {
            ob = EBObserver(eventName: key, action: subscribe)
            _observerPool[key] = ob
        }
        
        ob?.action = subscribe
    }
    
    func unregister(_ key: String) {
        var ob = _observerPool[key]
        ob?.action = nil
        
        _observerPool.removeValue(forKey: key)
    }
    
    func emit(_ key: String, _ arg: Any?) {
        if let ob = _observerPool[key] {
            ob.action?(arg)
        }
    }
}
