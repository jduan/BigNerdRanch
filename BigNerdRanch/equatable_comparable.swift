//
// Created by jingjing_duan on 4/23/18.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

struct Point: Equatable {
    let x: Int
    let y: Int

    // you automatically get !=
    static func ==(lhs: Point, rhs: Point) -> Bool {
        return (lhs.x == rhs.x) && (lhs.y == rhs.y)
    }
}
