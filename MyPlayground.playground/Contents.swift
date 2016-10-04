//: Playground - noun: a place where people can play

import UIKit

var optionalName: String? = "parna"
var greeting = "Hello!"
if let name = optionalName , name.hasPrefix("A") {
    greeting = "Hello, \(name)"
}
else {
    print("nil value")
}

class NamedShape {
    var numberOfSides = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

protocol ExampleProtocol {
    var simpleDescription: String { get }
    func adjust()
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "  Now 100% adjusted."
    }
}

class SimpleClass2: ExampleProtocol {
    var simpleDescription: String = "Another very simple class."
    func adjust() {
        simpleDescription += "  Adjusted."
    }
}

var protocolArray: [ExampleProtocol] = [SimpleClass(), SimpleClass(), SimpleClass2()]
for instance in protocolArray {
    instance.adjust()
}
print(protocolArray)

func greet(_ person: String,_ age: Int = 0) -> String {
    let greeting = "Hello \(person). Your age is \(age)"
    return greeting
}

func metaGreet(_ person: String,_ age: Int, _ funcToCall: (_: String, _: Int)-> String) {
    print(funcToCall(person,age))
}

metaGreet(_: "Madhu", _: 36, _: greet)