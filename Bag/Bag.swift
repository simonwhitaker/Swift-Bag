//
//  Bag.swift
//  Bag
//
//  Created by Simon on 28/08/2017.
//  Copyright © 2017 Simon Whitaker. All rights reserved.
//

import Foundation

struct Bag<T: Hashable> {
  fileprivate var storage: Dictionary<T, Int>

  init() {
    storage = Dictionary<T, Int>()
  }

  mutating func add (_ elem: T) {
    if let currentCount = self.storage[elem] {
      self.storage[elem] = currentCount + 1;
    } else {
      self.storage[elem] = 1
    }
  }

  func isSubBag (of superbag: Bag<T>) -> Bool {
    for (key, count) in self.storage {
      if let superbagcount = superbag.storage[key] {
        if count > superbagcount {
          return false
        }
      } else {
        return false
      }
    }
    return true
  }

  var count: Int {
    get {
      return self.storage.count
    }
  }

  func count(for key: T) -> Int {
    if let count = self.storage[key] {
      return count
    }
    return 0
  }
}

extension Bag: Equatable {
  static func == (lhs: Bag<T>, rhs: Bag<T>) -> Bool {
    if lhs.storage.count != rhs.storage.count {
      return false
    }
    for (lkey, lcount) in lhs.storage {
      if let rcount = rhs.storage[lkey] {
        if lcount != rcount {
          // key exists in both, but counts are different
          return false
        }
      } else {
        // lkey doesn't exist in rhs.storage
        return false
      }
    }
    return true
  }
}
