//
//  main.swift
//  BigNerdRanch
//
//  Created by jingjing_duan on 4/7/18.
//  Copyright © 2018 jingjing_duan. All rights reserved.
//

import Cocoa
print("")

var myTown = Town(population: 0, stoplights: 6)
myTown?.printDescription()
myTown?.changePopulation(by: 500)
myTown?.printDescription()

let genericMonster = Monster(town: myTown, monsterName: "Luke")
genericMonster.terrorizeTown()

var fredTheZombie: Zombie? = Zombie(limp: false, fallingApart: false,
        town: myTown, monsterName: "Fred")
fredTheZombie?.terrorizeTown()
fredTheZombie?.town?.printDescription()

var convenientZombie = Zombie(limp: true, fallingApart: false)

print(Square.numberOfSides())
print(Cube.numberOfSides())

func greet(name: String, withGreeting greeting: String) -> String {
    return "\(greeting) \(name)"
}
func greeting(forName name: String) -> (String) -> String {
    func greeting(_ greeting: String) -> String {
        return "\(greeting) \(name)"
    }

    return greeting
}
print(greet(name: "Matt", withGreeting: "Hello, "))
let greetMattWith = greeting(forName: "Matt")
print(greetMattWith("Hello, "))

print("\n===\n")

let myTownSize = myTown?.townSize
print("myTownSize is \(myTownSize)")
print("myTownSize is \(myTownSize)")
print("myTownSize2 is \(myTown?.townSize2())")
print("myTownSize3 is \(myTown?.townSize3)")
myTown?.population = 1_000_000
print("myTownSize3 is \(myTown?.townSize3)")

print("\n===\n")

print("Victim pool: \(fredTheZombie?.victimPool)")
fredTheZombie?.victimPool = 500
print("Victim pool: \(fredTheZombie?.victimPool)")

// This will trigger deinitialization
fredTheZombie = nil

print("\n===\n")

var str = "Hello, playground"
var playgroundGreeting = str
playgroundGreeting += "! How are you today?"
// String is a value type. Value types are always copied when they are assigned
// to an instance or passed as an argument to a function.
print(str)

class GreekGod {
    var name: String
    init(name: String) {
        self.name = name
    }
}
let hecate = GreekGod(name: "Hecate")
// both of them point to the same instance of the GreekGod class!
let anotherHecate = hecate
anotherHecate.name = "AnotherHecate"
print(hecate.name)

struct Pantheon {
    var chiefGod: GreekGod

    mutating func changeGod(newGod: GreekGod) {
        chiefGod = newGod
    }
}
let pantheon = Pantheon(chiefGod: hecate)
let zeus = GreekGod(name: "Zeus")
// The following line doesn't compile because "pantheon" is a struct
// and structs are value types. Value types can't change their properties
// even if those properties are declared with var. (they can only be set once)
//pantheon.chiefGod = zeus

// The next line won't compile because:
// cannot use mutating member on immutable value: 'pantheon' is a 'let' constant
//pantheon.changeGod(newGod: zeus)

var pantheon2 = Pantheon(chiefGod: hecate)
pantheon2.changeGod(newGod: zeus)
print("Pantheon's god is \(pantheon2.chiefGod.name)")

// You can change the properties of a constant that's an instance of a reference type.
// You aren't changing what "zeus" really is. No matter how many times you change zeus's
// name, zeus still refers to the same instance.
zeus.name = "Zeus Jr."
print("Zeus's name is \(zeus.name)")
// The next line won't compile because you can't reassign a "let" constant
//zeus = GreekGod(name: "Zeus2")

print("\n===\n")

// This demos the complications of placing a reference type within a value type.
// When you a copy a value type, the reference type inside it won't be copied.
// Instead the same reference will be used.
print(pantheon.chiefGod.name)
let greekPantheon = pantheon
hecate.name = "Trivia"
print(greekPantheon.chiefGod.name)

print("\n===\n")

let athena = GreekGod(name: "Athena")
let gods = [athena, hecate, zeus]
let godsCopy = gods
gods.last?.name = "Jupiter"
// Both gods and godsCopy's last element have been changed!
print("gods: \(gods.last?.name)")
print("godsCopy: \(godsCopy.last?.name)")

/////////////////////////////////////////////////////////////////////////////
// protocols
/////////////////////////////////////////////////////////////////////////////

struct Person {
    let name: String
    let age: Int
    let yearsOfExperience: Int
}

protocol TabularDataSource {
    // for read-write properties, use "{ get set }"
    var numberOfRows: Int { get }
    var numberOfColumns: Int { get }

    func label(forColumn column: Int) -> String
    func itemFor(row: Int, column: Int) -> String
}

// implements multiple Protocols
struct Department: TabularDataSource, CustomStringConvertible {
    let name: String
    var people = [Person]()

    init(name: String) {
        self.name = name
    }

    mutating func add(_ person: Person) {
        people.append(person)
    }

    var numberOfRows: Int {
        return people.count
    }

    var numberOfColumns: Int {
        return 3
    }

    func label(forColumn column: Int) -> String {
        switch column {
        case 0: return "Employee Name"
        case 1: return "Age"
        case 2: return "Years of Experience"
        default: fatalError("Invalid column!")
        }
    }

    func itemFor(row: Int, column: Int) -> String {
        let person = people[row]
        switch column {
        case 0: return person.name
        case 1: return String(person.age)
        case 2: return String(person.yearsOfExperience)
        default: fatalError("Invalid column!")
        }
    }

    var description: String {
        return "Department (\(name))"
    }
}

var department = Department(name: "Engineering")
print("Department: \(department)")
department.add(Person(name: "Joe", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Karen", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Fred", age: 50, yearsOfExperience: 20))

// use a Protocol in a function
func printTable(_ dataSource: TabularDataSource) {
    // keep track of the width of each column
    var columnWidths = [Int]()

    // Create first row containing column headers
    var firstRow = "|"
    var i = 0
    while i < dataSource.numberOfColumns {
        let columnLabel = dataSource.label(forColumn: i)
        let columnHeader = " \(columnLabel) |"
        firstRow += columnHeader
        columnWidths.append(columnLabel.count)
        i += 1
    }
    print(firstRow)

    for i in 0 ..< dataSource.numberOfRows {
        var out = "|"
        for j in 0 ..< dataSource.numberOfColumns {
            let item = dataSource.itemFor(row: i, column: j)
            let paddingNeeded = columnWidths[j] - item.count
            let padding = repeatElement(" ", count: paddingNeeded).joined(separator: "")
            out += " \(padding)\(item) |"
        }
        print(out)
    }
}

printTable(department)
