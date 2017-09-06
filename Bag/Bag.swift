//
//  Bag.swift
//  Bag
//
//  Created by Simon on 28/08/2017.
//  Copyright © 2017 Simon Whitaker. All rights reserved.
//

import Foundation

public struct Bag<T: Hashable> {
  private var storage: [T: UInt] = [:]
  public private(set) var count: UInt = 0

  public init() {}

  public init<C: Collection>(_ collection: C) where C.Element == T {
    for element in collection {
      self.add(element)
    }
  }

  public mutating func add (_ elem: T) {
    storage[elem, default: 0] += 1
    count += 1
  }

  public mutating func remove (_ elem: T) {
    if let currentCount = storage[elem] {
      if currentCount > 1 {
        storage[elem] = currentCount - 1
      } else {
        storage.removeValue(forKey: elem)
      }
      count -= 1
    }
  }

  public func isSubBag (of superbag: Bag<T>) -> Bool {
    for (key, count) in storage {
      let superbagcount = superbag.storage[key] ?? 0
      if count > superbagcount {
        return false
      }
    }
    return true
  }

  public func count(for key: T) -> UInt {
    return storage[key] ?? 0
  }

  public var allItems: [T] {
    var result = [T]()
    for (key, count) in storage {
      for _ in 0 ..< count {
        result.append(key)
      }
    }
    return result
  }
}

// MARK: - Equatable
extension Bag: Equatable {
  public static func == (lhs: Bag<T>, rhs: Bag<T>) -> Bool {
    if lhs.storage.count != rhs.storage.count {
      return false
    }
    for (lkey, lcount) in lhs.storage {
      let rcount = rhs.storage[lkey] ?? 0
      if lcount != rcount {
        return false
      }
    }
    return true
  }
}
