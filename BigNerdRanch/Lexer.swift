//
// Created by jingjing_duan on 4/16/18.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

enum Token {
    case number(Int)
    case plus
}

class Lexer {
    // Swift.Error is an empty protocol. That is, it does not require any properties or
    // methods to be present. Any type you write can conform to Error just by stating that it does,
    // but enumerations are by far the most common Errors.
    enum Error: Swift.Error {
        case invalidCharacter(Character)
    }

    let input: String
    var position: String.Index

    init(input: String) {
        self.input = input
        self.position = self.input.startIndex
    }

    // Return the next character or nil
    func peek() -> Character? {
        guard position < input.endIndex else {
            return nil
        }
        return input[position]
    }

    func advance() {
        assert(position < input.endIndex, "Cannot advance past endIndex!")
        position = input.index(after: position)
    }

    func lex() throws -> [Token] {
        var tokens = [Token]()

        while let nextCharacter = peek() {
            switch nextCharacter {
            case "0" ... "9":
                let value = getNumber()
                tokens.append(.number(value))
            case "+":
                tokens.append(.plus)
                advance()
            case " ":
                // just advance to ignore spaces
                advance()
            default:
                throw Lexer.Error.invalidCharacter(nextCharacter)
            }
        }

        return tokens
    }

    func getNumber() -> Int {
        var value = 0
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "0" ... "9":
                // Another digit - add it into value
                let digitValue = Int(String(nextCharacter))!
                value = 10 * value + digitValue
                advance()
            default:
                // A nondigit - go back to regular lexing
                return value
            }
        }

        return value
    }
}
