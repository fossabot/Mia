import XCTest
import UIKit

struct Person: Codable {
    var name: String
    var age: Int
    var dob: Date
}

class CodableKitTests: XCTestCase {

    func testExample() {

        let mike = Person(name: "Michael", age: 26, dob: Date(year: 1991, month: 8, day: 15))
        let sara = Person(name: "Sara", age: 23, dob: Date(year: 1994, month: 9, day: 22))
        let array = [ mike, sara ]

        let mikeData = mike.toData()
        // print("mike.toData(): ", mikeData)

        let arrayData = array.toData()
        // print("array.toData(): ", arrayData)

        let mikeDict = mike.toDictionary()
        print("mike.toDictionary(): ", mikeDict, "\n\n")

        let arrayDict = array.toArray()
        print("array.toArray(): ", arrayDict, "\n\n")

        let mikeString = mike.toString()
        print("mike.toString(): ", mikeString, "\n\n")

        let arrayString = array.toString()
        print("array.toString(): ", arrayString, "\n\n")

        let newMikeModelData = Person.decode(from: mikeData)!
        print(newMikeModelData, "\n\n")

        let newArrayModelData = [ Person ].decode(from: arrayData)!
        print(newArrayModelData, "\n\n")

        let newMikeModelString = Person.decode(from: mikeString)!
        print(newMikeModelString, "\n\n")

        let newArrayModelString = [ Person ].decode(from: arrayString)!
        print(newArrayModelString, "\n\n")
    }
}
