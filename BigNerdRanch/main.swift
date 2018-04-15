//
//  main.swift
//  BigNerdRanch
//
//  Created by jingjing_duan on 4/7/18.
//  Copyright © 2018 jingjing_duan. All rights reserved.
//

import Cocoa
print("")

var myTown = Town(population: 10_000, stoplights: 6)
myTown.printDescription()
myTown.changePopulation(by: 500)
myTown.printDescription()

let genericMonster = Monster(town: myTown, monsterName: "Luke")
genericMonster.terrorizeTown()

let fredTheZombie = Zombie(limp: false, fallingApart: false,
        town: myTown, monsterName: "Fred")
fredTheZombie.terrorizeTown()
fredTheZombie.town?.printDescription()

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

let myTownSize = myTown.townSize
print("myTownSize is \(myTownSize)")
print("myTownSize is \(myTownSize)")
print("myTownSize2 is \(myTown.townSize2())")
print("myTownSize3 is \(myTown.townSize3)")
myTown.population = 1_000_000
print("myTownSize3 is \(myTown.townSize3)")

print("\n===\n")

print("Victim pool: \(fredTheZombie.victimPool)")
fredTheZombie.victimPool = 500
print("Victim pool: \(fredTheZombie.victimPool)")
