# An implementation of the bag data stucture in Swift

## Usage

``` swift
var b = Bag<Character>();
for c in "hello".characters {
  b.add(c)
}
let count = b.count // count is 5
let lcount = b.count(for: "l") // lcount is 2
```
