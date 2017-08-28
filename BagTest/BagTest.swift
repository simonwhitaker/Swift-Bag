//
//  BagTest.swift
//  BagTest
//
//  Created by Simon on 28/08/2017.
//  Copyright © 2017 Simon Whitaker. All rights reserved.
//

import XCTest

extension Bag where T == Character {
  init(_ s: String) {
    self.init()
    for c in s.characters {
      self.add(c)
    }
  }
}

class BagTest: XCTestCase {
  func testAddAndCount() {
    let b = Bag<Character>("abcd")
    XCTAssertEqual(b.count, 4)
  }

  func testCountWithDuplicates() {
    let b = Bag<Character>("aab")
    XCTAssertEqual(b.count, 3)
    XCTAssertEqual(b.count(for: "a"), 2)
  }

  func testEquality() {
    let b = Bag<Character>("aaa")

    let b2 = Bag<Character>("aaa")
    XCTAssertEqual(b, b2)

    var b3 = Bag<Character>()
    XCTAssertNotEqual(b, b3)

    b3.add("a") // "a"
    XCTAssertNotEqual(b, b3)

    b3.add("a") // "aa"
    XCTAssertNotEqual(b, b3)

    b3.add("a") // "aaa"
    XCTAssertEqual(b, b3)

    b3.add("a") // "aaaa"
    XCTAssertNotEqual(b, b3)

    b3 = Bag<Character>("aaab")
    XCTAssertNotEqual(b, b3)
  }

  func testIsSubBag() {
    let b = Bag<Character>("aaa")
    let b2 = Bag<Character>("aa")

    XCTAssertTrue(b.isSubBag(of: b))
    XCTAssertTrue(b2.isSubBag(of: b))
    XCTAssertFalse(b.isSubBag(of: b2))
  }
}
