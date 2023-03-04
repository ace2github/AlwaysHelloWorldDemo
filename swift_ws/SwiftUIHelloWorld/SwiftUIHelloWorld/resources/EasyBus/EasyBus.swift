//
//  EasyBus.swift
//  SwiftUIHelloWorld
//
//  Created by chaohui chen on 2022/12/2.
//

import Foundation

/*
 0、
 view - responder
 object.bus.emit(.key)(.event, arg)
 
 viewcontroller - responder
 object.bus.register(.key){ event, arg in
    
 }
 
 object.bus.unregister(.key)
 
 1、实现基本的功能
    添加命名空间的概念，按照模块进行隔离
 
 
 2、考虑多线程和性能问题
    考虑事件合并策略（短时多个事件到来，则进行事件合并）
    事件回调优先级设置（有时候某个事件会短时间多次发送，则会阻塞bus）
    Obserber 和 Event 可能存在多次的创建和销毁，可以采用对象池，复用
    
    同一个页面，如详情页，则可能存在多个详情，这时候bus是复用，还是新的？ —— 交由业务方控制，底部不做管控
    一个事件对应一个监听者，还是一个事件可以对应多个监听者呢？
 
 3、考虑自我管理功能
    监听的block已经被释放，则应该清理bus
    工厂的bus已经被释放，则应该清理bus
 */
public protocol EasyBusCompatible {
    var bus: EBBus { get }
    
    func bus(_ ns: String) -> EBBus
    func disposeBus(_ ns: String)
}

extension EasyBusCompatible {
    public var bus: EBBus {
        get {
            return EBBusManager.factory("define")
        }
    }
    
    public func bus(_ ns: String) -> EBBus {
        return EBBusManager.factory(ns)
    }
    
    public func disposeBus(_ ns: String) {
        return EBBusManager.removeBus(ns)
    }
}

extension NSObject : EasyBusCompatible {
    
}
