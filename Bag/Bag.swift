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
  private var _count: Int = 0

  init() {
    storage = Dictionary<T, Int>()
  }

  mutating func add (_ elem: T) {
    if let currentCount = self.storage[elem] {
      self.storage[elem] = currentCount + 1;
    } else {
      self.storage[elem] = 1
    }
    _count += 1
  }

  mutating func remove (_ elem: T) {
    if let currentCount = self.storage[elem] {
      if currentCount > 1 {
        self.storage[elem] = currentCount - 1
      } else {
        self.storage.removeValue(forKey: elem)
      }
      _count -= 1
    }
  }

  func isSubBag (of superbag: Bag<T>) -> Bool {
    for (key, count) in self.storage {
      let superbagcount = superbag.storage[key] ?? 0
      if count > superbagcount {
        return false
      }
    }
    return true
  }

  var count: Int {
    get {
      return _count
    }
  }

  func count(for key: T) -> Int {
    return self.storage[key] ?? 0
  }
}

extension Bag: Equatable {
  static func == (lhs: Bag<T>, rhs: Bag<T>) -> Bool {
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
