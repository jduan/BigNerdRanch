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
}
