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

struct Book {
    let title: String
    let author: String
    let averageReviews: Double
}

struct BookCollection: TabularDataSource {
    var books = [Book]()

    mutating func add(_ book: Book) {
        books.append(book)
    }

    var numberOfRows: Int {
        return books.count
    }

    var numberOfColumns: Int {
        return 3
    }

    func label(forColumn column: Int) -> String {
        switch column {
        case 0: return "Title"
        case 1: return "Author"
        case 2: return "Average Reviews"
        default: fatalError("Invalid column!")
        }
    }

    func itemFor(row: Int, column: Int) -> String {
        let book = books[row]
        switch column {
        case 0: return book.title
        case 1: return book.author
        case 2: return String(book.averageReviews)
        default: fatalError("Invalid column!")
        }
    }
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
// Protocol composition: combine multiple protocols into a single requirement!
func printTable(_ dataSource: TabularDataSource & CustomStringConvertible) {
    print("Table: \(dataSource.description)")
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

/////////////////////////////////////////////////////////////////////////////
// Error Handling
print("\n === \n")
/////////////////////////////////////////////////////////////////////////////
func evaluate(_ input: String) {
    print("Evaluating: \(input)")
    let lexer = Lexer(input: input)
    do {
        let tokens = try lexer.lex()
        print("Lexer output: \(tokens)")

        let parser = Parser(tokens: tokens)
        let result = try parser.parse()
        print("Parser result: \(result)")
    } catch Lexer.Error.invalidCharacter(let char) {
        print("Input contained an invalid character: \(char)")
    } catch Parser.Error.unexpectedEndOfInput {
        print("Unexpected end of input during parsing")
    } catch Parser.Error.invalidToken(let token) {
        print("Invalid token during parsing: \(token)")
    } catch {
        // "error" is a pre-defined constant by the compiler
        print("An unknown error occurred: \(error)")
    }
}
evaluate("10 + 3 + 5")
evaluate("10 + 3 + 5 - 1 - 2")
evaluate("1 + 2 + abcdefg")
evaluate("1 + 2 +")
evaluate("1 + 2 + 5 3")
evaluate("1 + 2 ++")

/////////////////////////////////////////////////////////////////////////////
// Extensions
print("\n === \n")
/////////////////////////////////////////////////////////////////////////////

var c = Car(make: "Ford", model: "Fusion", year: 2013, gasLevel: 0.7)
print("car: \(c)")
print("car top speed: \(c.topSpeed)")
print("kind: \(c.kind)")
c.emptyGas(by: 0.3)
print("gas level: \(c.gasLevel)")
c.fillGas()
print("gas level: \(c.gasLevel)")

print("5.timesFive: \(5.timesFive)")

/////////////////////////////////////////////////////////////////////////////
print("\n Generics \n")
/////////////////////////////////////////////////////////////////////////////

var intStack = Stack<Int>()
intStack.push(1)
intStack.push(2)
print(intStack.pop())
print(intStack.pop())
print(intStack.pop())

var stringStack = Stack<String>()
stringStack.push("this is a string")
stringStack.push("this is another string")
print(stringStack.pop())

func myMap<T, U>(_ items: [T], _ f: (T) -> (U)) -> [U] {
    var result = [U]()
    for item in items {
        result.append(f(item))
    }
    return result
}
let strings = ["one", "two", "three"]
let stringLengths: [Int] = myMap(strings) { $0.count }
print(stringLengths)

var intStack2 = Stack<Int>()
var doubledStack = intStack2.map { 2 * $0 }
print(doubledStack.pop())
print(doubledStack.pop())

// Using a type constraint to allow checking for equality
// T must conform to the Equatable protocol
func checkIfEqual<T: Equatable>(_ first: T, _ second: T) -> Bool {
    return first == second
}
print(checkIfEqual(1, 1))
print(checkIfEqual("a string", "a string"))
print(checkIfEqual("a string", "a different string"))

// Both T and U conform to the CustomStringConvertible protocol, but
// they don't have to be the same type.
func checkIfDescriptionsMatch<T: CustomStringConvertible, U: CustomStringConvertible>(
        _ first: T, _ second: U) -> Bool {
    return first.description == second.description
}

print(checkIfDescriptionsMatch(Int(1), UInt(1)))
print(checkIfDescriptionsMatch(1, 1.0))
print(checkIfDescriptionsMatch(Float(1.0), Double(1.0)))

var stack3 = Stack<Int>()
stack3.pushAll([1, 2, 3])
print("stack3 is \(stack3)")

var stack3Filtered = stack3.filter { $0 > 1 }
print("stack3Filtered is \(stack3Filtered)")

func findAll<T: Equatable>(items: [T], target: T) -> [Int]? {
    var i = 0
    var indices = [Int]()
    while i < items.count {
        if items[i] == target {
            indices.append(i)
        }
        i += 1
    }

    return indices
}
print(findAll(items: [5, 3, 7, 3, 9], target: 3) == [1, 3])

/////////////////////////////////////////////////////////////////////////////
print("\n Protocol Extensions \n")
/////////////////////////////////////////////////////////////////////////////

let ellipticalWorkout = EllipticalWorkout(caloriesBurned: 335, minutes: 30)
let runningWorkout = TreadmillWorkout(caloriesBurned: 350, minutes: 25, laps: 10.5)
print("calories burned per minute: \(caloriesBurnedPerMinutes(for: runningWorkout))")
print("calories burned per minute: \(runningWorkout.caloriesBurnedPerMinutes)")

let mondayWorkout: [Exercise] = [ellipticalWorkout, runningWorkout]
print(mondayWorkout.totalCaloriesBurned())

print(ellipticalWorkout)
print(runningWorkout)

for exercise in mondayWorkout {
    print("title: \(exercise.title)")
}
//  Here is what is most important to understand: Be careful when you are considering writing a
//  protocol extension that adds properties or methods that are not default implementations for
//  requirements of the protocol. The runtime behavior may not be what you expect if conforming
//  types also implement those same properties and methods.
print("ellipticalWorkout's title: \(ellipticalWorkout.title)")

/////////////////////////////////////////////////////////////////////////////
print("\n Memory Management \n")
/////////////////////////////////////////////////////////////////////////////

var bob: MM.Person? = MM.Person(name: "Bob")
print("created \(bob)")

var laptop: MM.Asset? = MM.Asset(name: "Shiny Laptop", value: 1500.0)
var hat: MM.Asset? = MM.Asset(name: "Cowboy Hat", value: 175.0)
var backpack: MM.Asset? = MM.Asset(name: "Blue Backpack", value: 45.0)

bob?.takeOwnership(of: laptop!)
bob?.useNetWorthChangedHandler {
    netWorth in
    print("Bob's net worth is now \(netWorth)")
}
bob?.takeOwnership(of: hat!)
bob?.relinquishOwnership(of: hat!)

print("While Bob is alive, hat's owner is \(hat!.owner)")
bob = nil
print("the bob variable is now \(bob)")
print("After Bob is deallocated, hat's owner is \(hat!.owner)")
laptop = nil
hat = nil
backpack = nil

/////////////////////////////////////////////////////////////////////////////
print("\n Equatable and Comparable \n")
/////////////////////////////////////////////////////////////////////////////

let a = Point(x: 3, y: 4)
let b = Point(x: 3, y: 4)
print("a == b: \(a == b)")
print("a != b: \(a != b)")
let c2 = Point(x: 2, y: 6)
let d = Point(x: 3, y: 7)
print("c < d: \(c2 < d)")
print("c <= d: \(c2 <= d)")
print("c > d: \(c2 > d)")
print("c >= d: \(c2 >= d)")
print("c + d: \(c2 + d)")

let p1 = Person2(name: "Jingjing", age: 37)
let p2 = Person2(name: "Qingqing", age: 34)
let people: [Person2] = [p1, p2]
print("people: \(people)")
let idx = people.index(where: { $0 == p1 })
print("idx: \(idx)")
