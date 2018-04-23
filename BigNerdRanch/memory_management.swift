//
// Created by jingjing_duan on 4/21/18.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

struct MM {
    class Person: CustomStringConvertible {
        let name: String
        var assets = [Asset]()
        var description: String {
          return "Person(\(name))"
        }

        init(name: String) {
            self.name = name
        }

        deinit {
            print("\(self) is being deallocated")
        }

        func takeOwnership(of asset: Asset) {
            asset.owner = self
            assets.append(asset)
        }
    }

    class Asset: CustomStringConvertible {
        let name: String
        let value: Double
        weak var owner: Person?
        var description: String {
            if let actualOwner = owner {
                return "Asset(\(name), worth \(value), owned by \(actualOwner))"
            } else {
                return "Asset(\(name), worth \(value), not owned by anyone)"
            }
        }

        init(name: String, value: Double) {
            self.name = name
            self.value = value
        }

        deinit {
            print("\(self) is being deallocated")
        }
    }
}
