// Copyright (c) 2021 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import Foundation

public struct Stack<Element> {
    
    private var storage: [Element] = []
    
    public init() {}
}

extension Stack: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        """
----top----
\(storage.map { "\($0)"}.reversed().joined(separator: "\n"))
-----------
"""
    }
}

extension Stack {
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    @discardableResult
    public mutating func pop() -> Element? {
        storage.popLast()
    }
    
    public func peek() -> Element? {
        storage.last
    }
    
    public var isEmpty: Bool {
        peek() == nil
    }
}

extension Stack {
    
    public init(_ elements: [Element]) {
        storage = elements
    }
}

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}

example(of: "using a stack") {
    var stack = Stack<Int>()
    stack.push(1)
    stack.push(2)
    stack.push(3)
    stack.push(4)
    
    print(stack)
    
    if let poppedElemant = stack.pop() {
        assert(4 == poppedElemant)
        print("Popped: \(poppedElemant)")
    }
}

example(of: "initializing a a stack from an array") {
    let array = ["A", "B", "C", "D"]
    var stack = Stack(array)
    print(stack)
    stack.pop()
}

example(of: "initializing a stack from an array literal") {
    var stack: Stack = [1.0, 2.0, 3.0, 4.0]
    print(stack)
    stack.pop()
  }


func isBalansedParentheses(string: String) -> Bool {
    var stack: Stack<Character> = []

    for character in string {
        if character == "(" {
            stack.push(character)
        } else if character == ")" {
            if stack.isEmpty {
                return true
            } else {
                stack.pop()
            }
        }
    }
    
    return stack.isEmpty
}

isBalansedParentheses(string: "(hello world")

// HELPERS
public func example(of description: String, action: () -> ()) {
  print("---Example of \(description)---")
  action()
  print()
}
