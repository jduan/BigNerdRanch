//
// Created by jingjing_duan on 4/19/18.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

typealias Velocity = Double

extension Velocity {
    // add two computed properties
    var kph: Velocity { return self * 1.60934 }
    var mph: Velocity { return self }
}

protocol Vehicle {
    var topSpeed: Velocity { get }
    var numberOfDoors: Int { get }
    var hasFlatbed: Bool { get }
}

struct Car {
    let make: String
    let model: String
    let year: Int
    let color: String
    let nickname: String
    var gasLevel: Double {
        willSet {
            precondition(newValue <= 1.0 && newValue >= 0.0,
                    "New value must be between 0 and 1.")
        }
    }
}

extension Car: Vehicle {
    var topSpeed: Velocity { return 180 }
    var numberOfDoors: Int { return 4 }
    var hasFlatbed: Bool { return false }
}

// Recall that structs give you a free memberwise initializer if you do not provide your own. If you
// want to write a new initializer for your struct, but do not want to lose the memberwise
// initializer, you can add the initializer to your type with an extension. Add an initializer to
// Car in a new extension on the type.
extension Car {
    init(make: String, model: String, year: Int) {
        self.init(make: make, model: model, year: year, color: "Black",
                nickname: "N/A", gasLevel: 1.0)
    }
}

// Create an extension with a nested type
extension Car {
    enum Kind {
        case coupe, sedan
    }

    var kind: Kind {
        if numberOfDoors == 2 {
            return .coupe
        } else {
            return .sedan
        }
    }
}

// Extend a type with a function
extension Car {
    mutating func emptyGas(by amount: Double) {
        precondition(amount <= 1 && amount > 0,
                "Amount to remove must be between 0 and 1.")
        gasLevel -= amount
    }

    mutating func fillGas() {
        gasLevel = 1.0
    }
}