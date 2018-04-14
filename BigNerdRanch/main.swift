//
//  main.swift
//  BigNerdRanch
//
//  Created by jingjing_duan on 4/7/18.
//  Copyright © 2018 jingjing_duan. All rights reserved.
//

import Cocoa
print("")

var myTown = Town()
myTown.printDescription()
myTown.changePopulation(by: 500)
myTown.printDescription()

let genericMonster = Monster()
genericMonster.town = myTown
genericMonster.terrorizeTown()

let fredTheZombie = Zombie()
fredTheZombie.town = myTown
fredTheZombie.terrorizeTown()
fredTheZombie.town?.printDescription()

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
