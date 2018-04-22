//
// Created by jingjing_duan on 4/20/18.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

protocol Exercise: CustomStringConvertible {
    var name: String { get }
    var caloriesBurned: Double { get }
    var minutes: Double { get }
}

struct EllipticalWorkout: Exercise {
    let name = "Elliptical Workout"
    let caloriesBurned: Double
    let minutes: Double
}

struct TreadmillWorkout: Exercise {
    let name = "Treadmill Workout"
    let caloriesBurned: Double
    let minutes: Double
    let laps: Double
}

func caloriesBurnedPerMinutes<E: Exercise>(for exercise: E) -> Double {
    return exercise.caloriesBurned / exercise.minutes
}

// Extend a protocol
extension Exercise {
    var caloriesBurnedPerMinutes: Double {
        return caloriesBurned / minutes
    }
}

// Since Exercise inherits from CustomStringConvertible, if we don't provide
// an implementation here, structs that extend Exercise (such as EllipticalWorkout)
// would need to implement it itself. Here, we provide a default implementation.
extension Exercise {
    var description: String {
        return "Exercise(\(name), burned \(caloriesBurned) calories in \(minutes) minutes"
    }
}

// Override a protocol's default implementation
extension TreadmillWorkout {
    var description: String {
        return "TreadmillWrokout(\(caloriesBurned) calories and \(laps) laps in \(minutes) minutes)"
    }
}

// Protocol Extension where clauses
extension Sequence where Iterator.Element == Exercise {
    func totalCaloriesBurned() -> Double {
        var total: Double = 0
        for exercise in self {
            total += exercise.caloriesBurned
        }
        return total
    }
}