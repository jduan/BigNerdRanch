//
// Created by jingjing_duan on 4/12/18.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

struct Town {
    let region: String

    var mayor: Mayor = Mayor()

    var population: Int {
        // property observers
        // * when a property is about to change, via willSet
        // * when a property did change, via didSet
        didSet(oldPopulation) {
            print("The population has changed to \(population) from \(oldPopulation)")
            mayor.logTragedy()
        }
    }
    var numberOfStoplights: Int

    // failable initializer
    init?(population: Int, stoplights: Int, region: String) {
        guard population > 0 else {
            return nil
        }
        // Even thought "region" is a constant, the compiler allows you to initialize a constant
        // property at one point during initialization.
        self.region = region
        self.population = population
        numberOfStoplights = stoplights
    }

    // initializer delegation
    init?(population: Int, stoplights: Int) {
        self.init(population: population, stoplights: stoplights, region: "N/A")
    }

    // nested types
    enum Size {
        case small
        case medium
        case large
    }

    // lazy stored property
    // {...} is a closure
    lazy var townSize: Size = {
        // This print line shows this closure is evaluated once!
        // Making townSize a lazy property is problematic because even if you
        // change the population to 1_000_000, it would still be a "small" town.
        // This kind of discrepancy between myTown’s population and townSize is undesirable. It
        // seems that townSize should not be marked lazy, if lazy means that myTown will not be able
        // to recalibrate its townSize to reflect population changes. In the right circumstances,
        // lazy loading is a powerful tool. You will use it again in Chapter 27. But, in this case,
        // it is not the best tool for the job. A computed property is a better option.
        print("calculating townSize")
        switch self.population {
        case 0...10_000:
            return .small
        case 10_001...100_000:
            return .medium
        default:
            return .large
        }
    }()

    // This function works too but it's function, not a lazy property
    func townSize2() -> Size {
        switch self.population {
        case 0...10_000:
            return .small
        case 10_001...100_000:
            return .medium
        default:
            return .large
        }
    }

    // computed properties (evaluated every time the property is accessed)
    var townSize3: Size {
        get {
            switch self.population {
            case 0...10_000:
                return .small
            case 10_001...100_000:
                return .medium
            default:
                return .large
            }
        }
    }

    func printDescription() {
        print("""
                Population: \(population),
                number of stoplights: \(numberOfStoplights),
                region: \(region)
              """)
    }

    mutating func changePopulation(by amount: Int) {
        population += amount
        if population < 0 {
            population = 0
        }
    }
}
