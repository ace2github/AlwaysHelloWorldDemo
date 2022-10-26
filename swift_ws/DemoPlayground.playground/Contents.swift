
import UIKit

func checkPalindroneStr(_ str: String) -> Bool {
    let list = Array(str.lowercased())
    var start = 0
    var end = list.count-1
    while start < end {
        while start<end && !(list[start].isNumber || list[start].isLetter) {
            start+=1
        }
        
        while start < end && !(list[end].isLetter || list[end].isNumber) {
            end-=1
        }
        
        if start < end {
            if list[start] != list[end] {
                return false
            }
            
            start+=1
            end-=1
        }
    }
    
    return true
}

print(checkPalindroneStr("a 1`bc```cb`1a"))
print(checkPalindroneStr("ab`cxc`ba"))
print(checkPalindroneStr("race a car"))
print(checkPalindroneStr("A man, a plan, a canal: Panama"))


//func testFunc_0(name: String) {
//
//}
//testFunc_0(name: "haha")
//
//func testFunc_1(nickname name: String) {
//
//}
//testFunc_1(nickname: "123")
//
//
//
//func testFunc(_ name:String, age:Int=0, list:[String]) {
//    print("name:\(name), age:\(age), list:\(list)")
//}
//testFunc("hui", list: ["a", "b", "c"])
//testFunc("hui", age: 18, list: ["a", "b", "c"])

//let s1 = "123"
//let s2 = "123"
//print(s1 == s2)
//
//class Person {
//    var name = ""
//}
//let p1 = Person()
//let p2 = Person()
//print(p1 === p2)

//func arithmeticMean(_ name:String, _ numbers: Double...) -> Double {
//    var total: Double = 0
//    // numbers为double的数组
//    for number in numbers {
//        total += number
//    }
//    print(name)
//    return total / Double(numbers.count)
//}
//arithmeticMean("abc", 1, 2, 3, 4, 5)
//
//
//
//
//var str = "Hello, playground"
//
//func sayHelloWorld<T, N>(_ value:T, _ name:N) {
//    print("value:\(value) name:\(name)")
//}
//sayHelloWorld("hui", 36) // value:hui age:36
//sayHelloWorld(100, "Str") // value:100 name:Str
//
//
//
//print(NSObject.self)
//print(NSObject.classForCoder())
//
//let obj = NSObject()
//print(obj.self)
//print(obj.classForCoder)
//
//struct Stack<Element> {
//    var items = [Element]()
//    mutating func push(_ item: Element) {
//        items.append(item)
//    }
//    mutating func pop() -> Element {
//        return items.removeLast()
//    }
//}
//
//protocol SomeProtocol {
//    associatedtype T1:Equatable
//    associatedtype T2
//
//    var name:T1 {get set}
//    var value:T2 {get}
//}


