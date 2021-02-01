//
//  File.swift
//
//
//  Created by Gabriel O'Flaherty-Chan on 2021-02-01.
//

import Foundation

public extension Vector {
  static func * <V: Vector>(lhs: Self, rhs: V) -> Self where V.Primitive == Primitive {
    Self(components: lhs.components * rhs.components)
  }

  static func + <V: Vector>(lhs: Self, rhs: V) -> Self where V.Primitive == Primitive {
    Self(components: lhs.components + rhs.components)
  }

  static func - <V: Vector>(lhs: Self, rhs: V) -> Self where V.Primitive == Primitive {
    Self(components: lhs.components - rhs.components)
  }

  internal static var length: Int {
    Self(components: []).components.count
  }

  internal static var one: Self {
    Self(components: .init(repeating: 1, count: length))
  }

  internal static var zero: Self {
    Self(components: .init(repeating: 0, count: length))
  }
}

extension Vector where Primitive: Divisible {
  static func / <V: Vector>(lhs: Self, rhs: V) -> Self where V.Primitive == Primitive {
    Self(components: lhs.components / rhs.components)
  }
}

extension Array where Element: Numeric {
  static func * (lhs: Self, rhs: Self) -> Self {
    memberwiseOperation(lhs: lhs, rhs: rhs, operation: *)
  }

  static func + (lhs: Self, rhs: Self) -> Self {
    memberwiseOperation(lhs: lhs, rhs: rhs, operation: +)
  }

  static func - (lhs: Self, rhs: Self) -> Self {
    memberwiseOperation(lhs: lhs, rhs: rhs, operation: -)
  }

  static func memberwiseOperation(
    lhs: Self,
    rhs: Self,
    operation: (Element, Element) -> Element
  ) -> Self {
    let size = Swift.max(lhs.count, rhs.count)
    return zip(lhs.withSize(size), rhs.withSize(size)).map(operation)
  }

  func withSize(_ size: Int) -> Self {
    (0..<size).map { $0 < count ? self[$0] : 0 }
  }

  subscript(safe index: Index) -> Element? {
    indices.contains(index) ? self[index] : nil
  }
}

protocol Divisible: Numeric {
  static func / (lhs: Self, rhs: Self) -> Self
}

extension Float: Divisible {}
extension Double: Divisible {}
extension Int: Divisible {}

extension Array where Element: Divisible {
  static func / (lhs: Self, rhs: Self) -> Self {
    memberwiseOperation(lhs: lhs, rhs: rhs, operation: /)
  }
}
