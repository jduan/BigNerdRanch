//
// Created by jingjing_duan on 4/12/18.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

// Zombie is subclass of Monster
class Zombie: Monster {
    // Add a new property
    var walksWithLimp = true

    override class var spookyNoise: String {
        return "Grrr"
    }

    // "final" says subclasses of Zombie will not be able to override this method
    final override func terrorizeTown() {
        town?.changePopulation(by: -10)
        super.terrorizeTown()
    }
}
