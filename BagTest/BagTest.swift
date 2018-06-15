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
    for c in s {
      self.add(c)
    }
  }
}

class BagTest: XCTestCase {

  func testAddAndCount() {
    let b = Bag<Character>("abcd")
    XCTAssertEqual(b.count, 4)
  }

  func testRemove() {
    var b = Bag<Character>("abbd")
    XCTAssertEqual(b.count, 4)

    b.remove("b")
    XCTAssertEqual(b.count(for: "b"), 1);
    XCTAssertEqual(b.count, 3)

    b.remove("b")
    XCTAssertEqual(b.count(for: "b"), 0);
    XCTAssertEqual(b.count, 2)

    b.remove("b")
    XCTAssertEqual(b.count(for: "b"), 0);
    XCTAssertEqual(b.count, 2)

    b.add("b")
    XCTAssertEqual(b.count(for: "b"), 1);
    XCTAssertEqual(b.count, 3)

    b.remove("a")
    b.remove("b")
    b.remove("b")
    b.remove("d")
    XCTAssertEqual(b.count, 0)
  }

  func testCountWithDuplicates() {
    let b = Bag<Character>("aab")
    XCTAssertEqual(b.count, 3)
    XCTAssertEqual(b.count(for: "a"), 2)
  }

  func testEquality() {
    let b = Bag<Character>("aaa")

    var b2 = Bag<Character>("aaa")
    XCTAssertEqual(b, b2)

    b2 = Bag<Character>()
    XCTAssertNotEqual(b, b2)

    b2.add("a") // "a"
    XCTAssertNotEqual(b, b2)

    b2.add("a") // "aa"
    XCTAssertNotEqual(b, b2)

    b2.add("a") // "aaa"
    XCTAssertEqual(b, b2)

    b2.add("a") // "aaaa"
    XCTAssertNotEqual(b, b2)

    b2 = Bag<Character>("bbb")
    XCTAssertNotEqual(b, b2)
  }

  func testIsSubBag() {
    let b = Bag<Character>("aaa")
    let b2 = Bag<Character>("aa")

    XCTAssertTrue(b.isSubBag(of: b))
    XCTAssertTrue(b2.isSubBag(of: b))
    XCTAssertFalse(b.isSubBag(of: b2))

    // Test where subbag contains keys not present in superbag
    let b3 = Bag<Character>("ac")
    XCTAssertFalse(b3.isSubBag(of: b))
  }

}
