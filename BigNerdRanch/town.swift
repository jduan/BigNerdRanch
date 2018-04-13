//
// Created by jingjing_duan on 4/12/18.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

struct Town {
    var population = 5_422
    var numberOfStoplights = 4

    func printDescription() {
        print("Population: \(population), number of stoplights: \(numberOfStoplights)")
    }

    mutating func changePopulation(by amount: Int) {
        population += amount
        if population < 0 {
            population = 0
        }
    }
}
