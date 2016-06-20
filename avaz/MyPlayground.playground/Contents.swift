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

var someDoers = Doers()
var someInt: Int8 = 126
someDoers.doSomethings(675)
someDoers.doSomethingsNew(someInt)


