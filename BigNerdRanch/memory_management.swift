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
            accountant.gained(asset) {
                // Note that you did not have to say self.assets.append(asset). The compiler knows
                // that the closure passed to gained(_:completion:) is non-escaping, so it allows
                // you to refer to properties and methods on self implicitly.
                asset.owner = self
                assets.append(asset)
            }
        }

        func relinquishOwnership(of asset: Asset) {
            accountant.lost(asset) {
                asset.owner = nil
                // Find asset, assuming asset names are unique
                assets = assets.filter {$0.name != asset.name}
            }
        }

        func netWorthDidChange(to netWorth: Double) {
            print("The net worth of \(self) is now \(netWorth)")
        }

        func useNetWorthChangedHandler(handler: @escaping (Double) -> Void) {
            accountant.netWorthChangedHandler = handler
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
        func gained(_ asset: Asset, completion: () -> Void) {
            netWorth += asset.value
            completion()
        }
        func lost(_ asset: Asset, completion: () -> Void) {
            netWorth -= asset.value
            completion()
        }
    }
}
