//
// Created by jingjing_duan on 4/18/18.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

class Parser {
    enum Error: Swift.Error {
        case unexpectedEndOfInput
        case invalidToken(Token)
    }

    var tokens: [Token]
    var position = 0

    // [.number(5), .plus, .number(3)]
    init(tokens: [Token]) {
        self.tokens = tokens
    }

    func getNextToken() -> Token? {
        guard position < tokens.count else {
            return nil
        }
        let token = tokens[position]
        position += 1
        return token
    }

    func getNumber() throws -> Int {
        guard let token = getNextToken() else {
            throw Parser.Error.unexpectedEndOfInput
        }
        switch token {
        case .number(let value):
            return value
        default:
            throw Parser.Error.invalidToken(token)
        }
    }

    func parse() throws -> Int {
        // Require a number first
        var value = try getNumber()

        while let token = getNextToken() {
            switch token {
            case .plus:
                // after a plus, we must get another number
                let nextNumber = try getNumber()
                value += nextNumber
            case .minus:
                // after a minus, we must get another number
                let nextNumber = try getNumber()
                value -= nextNumber
            case .number:
                throw Parser.Error.invalidToken(token)
            }
        }

        return value
    }
}
