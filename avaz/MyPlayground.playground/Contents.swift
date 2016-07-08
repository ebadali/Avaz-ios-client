//: Playground - noun: a place where people can play

import UIKit


var str = "Hello, playground"


print(str)

let square = { (somevale: Int) -> Int in
    return somevale*somevale
}



for i in 1...5
{
    print("square of \(i) is \(square(i))")
}


protocol Doable {
    func doSomethings(someVars : Int)
}

class Doers: Doable {
    func doSomethings(someVars: Int) {
        print("i am doing something \(someVars)")
    }
}

extension Doers
{
    func doSomethingsNew(aVar : Int8) {
        print("i am doing something new \(aVar+1)")
    }
}

func tupleTest(sometuples: [String: AnyObject]) {
    print(sometuples["asd"])
    
    var strr=""
    for val in sometuples{
        strr += "\(val.0)=\(val.1)&"

    }
    strr=strr.substringToIndex(strr.endIndex.predecessor())
    print(strr)
}

var someDoers = Doers()
var someInt: Int8 = 126
someDoers.doSomethings(675)
someDoers.doSomethingsNew(someInt)


var sometuples = ["asd":45,"asdsa":6]
tupleTest(sometuples)

class Utils
{
//    static let sharedInstance = Utils()
//    private init() {}
    
    
    static func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

Utils.getDocumentsDirectory()

