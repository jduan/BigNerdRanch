//
// Created by jingjing_duan on 4/12/18.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

class Monster {
    var town: Town?
    var name = "Monster"

    func terrorizeTown() {
        if town != nil {
            print("\(name) is terrorizing a town!")
        } else {
            print("\(name) hasn't found a town to terrorize yet...")
        }
    }
}
