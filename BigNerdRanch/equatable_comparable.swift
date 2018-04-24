//
// Created by jingjing_duan on 4/23/18.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

struct Point: Comparable {
    let x: Int
    let y: Int

    // you automatically get !=
    static func ==(lhs: Point, rhs: Point) -> Bool {
        return (lhs.x == rhs.x) && (lhs.y == rhs.y)
    }

    // The Swift standard library defines the >, >=, and <= operators in terms
    // of the < and == operators.
    // This is why Comparable only requires that you overload the < operator.
    static func <(lhs: Point, rhs: Point) -> Bool {
        return (lhs.x < rhs.x) && (lhs.y < rhs.y)
    }

    static func +(lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

struct Person2: Equatable {
    let name: String
    let age: Int

    static func ==(lhs: Person2, rhs: Person2) -> Bool {
        return (lhs.name == rhs.name) && (lhs.age == rhs.age)
    }
}