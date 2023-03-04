//
//  EBObserver.swift
//  SwiftUIHelloWorld
//
//  Created by chaohui chen on 2022/12/2.
//

import Foundation

typealias EBAction = (_ arg: Any?) -> ()

struct EBObserver {
    var eventName: String
    var action: EBAction?
}
