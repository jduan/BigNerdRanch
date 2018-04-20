//
// Created by jingjing_duan on 4/19/18.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

// "Element" is a placeholder type. It can be used inside the Stack struct
// anywhere a concrete type could be used.
struct Stack<Element> {
    var items = [Element]()

    mutating func push(_ newItem: Element) {
        items.append(newItem)
    }

    mutating func pop() -> Element? {
        if items.isEmpty {
            return nil
        } else {
            return items.removeLast()
        }
    }
}