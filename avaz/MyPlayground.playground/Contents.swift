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

//Utils.getDocumentsDirectory()


var somstr = "Hello"
print ( somstr + "worl 2")

//var a:[CGFloat] = [1, 2, 3, 3.5]
//var b:[CGFloat] = [4]
var a:[String] = ["1","2","3"]
var b:[String] = ["4"]
//let index = 1
////if 0 ... a.count ~= index {
////    a[index..<index] = b[0..<b.count]
////}
//var finl = b.count + a.count
a[a.count..<a.count] = b[0..<b.count]

print(a)


//var a:[String: AnyObject] = ["1": 1 as  AnyObject ]
//var b:[String: AnyObject] = ["2": 2 as  AnyObject ]
//
//var newaerry = b.reduce(a) { (var dict, pair) in
//    dict[pair.0] = pair.1
//    return dict
//}
//print(newaerry)
//let values = [2.0,4.0,5.0,7.0]
//let squares2 = values.map{somevale in  (somevale*somevale) }
//print (squares2)

var images = ["11","22","33","44"]

//let multipliedFlattenedArray = values.flatMap { $0.map { $0+5 } }


let arry = images.flatMap { ( $0) }
print(arry)
//var arry = images.map({
//    (val: String ) -> String in
//    return val.map{}
//    }
//)
//print(arry)



//let values = [2.0,4.0,5.0,7.0]
//let squares2 = values.map({
//    (value: Double) -> String in
//    return String(value * value)
//})
//
//print(squares2)


let entries = ["x=5", "y=7", "z=10"]

let dict = entries.reduce([String:AnyObject]()) { (var dict, entry) in
    print("------")
    print(entry)
    print(dict.count)
    dict["file\(dict.count+1)"] = entry
    return dict
}

print("*******")
print(dict)
//for key in dict.keys {
//    print("Value for key '\(key)' is \(dict[key]).")
//}
let numbers = [7, 8, 9, 10]
let actualIndexAndNum: [String] = zip(numbers.indices, numbers).map { "\($0): \($1)" }
print(actualIndexAndNum)

//var a = ["a", "b", "c"]
//var b = ["d", "e", "f"]
//
//let res = [a, b].reduce([],combine:+)
//print(res)



