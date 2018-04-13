//
// Created by jingjing_duan on 4/12/18.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

class Vampire: Monster {
    override func terrorizeTown() {
        town?.changePopulation(by: -1)
        super.terrorizeTown()
    }
}
