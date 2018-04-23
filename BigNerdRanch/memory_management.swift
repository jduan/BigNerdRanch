//
// Created by jingjing_duan on 4/21/18.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

struct MM {
    class Person: CustomStringConvertible {
        let name: String
        let accountant = Accountant()
        var assets = [Asset]()
        var description: String {
          return "Person(\(name))"
        }

        init(name: String) {
            self.name = name
            accountant.netWorthChangedHandler = {
                [weak self] netWorth in
                self?.netWorthDidChange(to: netWorth)
                return
            }
        }

        deinit {
            print("\(self) is being deallocated")
        }

        func takeOwnership(of asset: Asset) {
            asset.owner = self
            assets.append(asset)
            accountant.gained(asset)
        }

        func netWorthDidChange(to netWorth: Double) {
            print("The net worth of \(self) is now \(netWorth)")
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

    class Accountant {
        typealias NetWorthChanged = (Double) -> Void
        var netWorthChangedHandler: NetWorthChanged? = nil
        var netWorth: Double = 0.0 {
            didSet {
                netWorthChangedHandler?(netWorth)
            }
        }
        func gained(_ asset: Asset) {
            netWorth += asset.value
        }
    }
}
