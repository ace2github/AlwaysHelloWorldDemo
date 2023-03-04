//
//  DataManager.swift
//  SwiftUIHelloWorld
//
//  Created by chaohui chen on 2022/11/30.
//

import Foundation
import HandyJSON
import SwiftyJSON
import UIKit

func testJson() {
    if let fileUrl = Bundle.main.url(forResource: "data", withExtension: "json") {
        let data = try? Data.init(contentsOf: fileUrl)
        
        let jsonString = "{\"doubleOptional\":1.1,\"stringImplicitlyUnwrapped\":\"hello\",\"int\":1}"
        if let object = BasicTypes.deserialize(from: jsonString) {
            print(object.int)
            print(object.doubleOptional!)
            print(object.stringImplicitlyUnwrapped!)
        }
        
        
        let s = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print(s ?? "")
        
        let jstr = try? String.init(contentsOf: fileUrl)
        if let userdata = UserData.deserialize(from: jstr) {
            print(userdata.list?[0].name ?? "")
        }
        
        
        let dic = try? JSON(data: data!)
        if let jsonObj = dic {
            //print(jsonObj)
            print(jsonObj["users"][0])
            print(jsonObj["users"][0]["name"].string ?? "")
        }
    }
}

class BasicTypes: HandyJSON {
    var int: Int = 2
    var doubleOptional: Double?
    var stringImplicitlyUnwrapped: String!

    required init() {}
}

class User : HandyJSON {
    var name: String = ""
    var age: Int = 0
    
    required init() {}
}

class UserData: HandyJSON {
    var dataTitle: String = ""
    var swiftVersion: Double = 0.0
    
    var list: [User]? = nil
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.list <-- "users"
    }
}
