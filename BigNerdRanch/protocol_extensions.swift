//
// Created by jingjing_duan on 4/20/18.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

protocol Exercise {
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