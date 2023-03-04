//
//  EBBusManager.swift
//  SwiftUIHelloWorld
//
//  Created by chaohui chen on 2022/12/2.
//

import Foundation

public class EBBusManager : NSObject {
    // 总线队列
    static var g_observerNameSpace: Dictionary<String, EBBus> = [:]
    
    static func factory(_ ns: String) -> EBBus{
        var bus = g_observerNameSpace[ns]
        if bus == nil {
            bus = EBBus()
            g_observerNameSpace[ns] = bus
        }
        
        return bus!
    }
    
    static func removeBus(_ ns: String) {
        g_observerNameSpace.removeValue(forKey: ns)
    }
}


