//
//  Helper.swift
//  transformation
//
//  Created by 신갈엔진맨 on 10/28/25.
//
import CoreGraphics
import Foundation

extension Graphics {
  static func centerPixel(_ v: CGFloat) -> CGFloat {
    return (round(v) + 0.5)
  }
  
  static func format(v: Double, fraction: Int) -> String {
    return String(format: "%.\(fraction)f", v)
  }
  
}
