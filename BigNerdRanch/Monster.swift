//
// Created by jingjing_duan on 4/12/18.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

class Monster {
    var town: Town?
    var name = "Monster"

    // static property: can't be overridden by subclasses!
    static let isTerrifying = true

    // computed class property
    class var spookyNoise: String {
        return "Brains..."
    }

    // getter and setter: read/write property
    var victimPool: Int {
        get {
            return town?.population ?? 0
        }
        set(newVictimPool) {
            town?.population = newVictimPool
        }
    }

    func terrorizeTown() {
        if town != nil {
            print("\(name) is terrorizing a town!")
        } else {
            print("\(name) hasn't found a town to terrorize yet...")
        }
    }
}
