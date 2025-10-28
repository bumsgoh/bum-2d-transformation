//
//  Shape.swift
//  transformation
//
//  Created by 신갈엔진맨 on 10/27/25.
//

import Foundation
import CoreGraphics
import SwiftUI

extension Graphics {
  
  enum SubMeshType: String, Comparable {
    static func < (lhs: Graphics.SubMeshType, rhs: Graphics.SubMeshType) -> Bool {
      lhs.sortOrder < rhs.sortOrder
    }
    
    case pivotPoint
    case body
    
    var sortOrder: Int {
      switch self {
      case .pivotPoint: return 1
      case .body: return 0
      }
    }
  }
  
  class Shape {
    
    private let pivotPointSize: CGFloat = 5
    
    var worldTransform: CGAffineTransform {
      return CGAffineTransform.identity
        .translatedBy(x: position.x, y: position.y)
        .rotated(by: rotation * .pi / 180)
        .translatedBy(x: -pivot.x,   y: -pivot.y)
    }
    
    var worldTranslation: CGAffineTransform {
      return CGAffineTransform.identity
        .translatedBy(x: position.x, y: position.y)
    }
    
    var pivot: CGPoint
    
    var position: CGPoint = .zero
    var rotation: CGFloat = .zero
    var scale: CGFloat = 1
    
    var material: [SubMeshType: Material] = [.pivotPoint: .init(color: .red)]
    
    init() {
      self.pivot = .zero
    }
    
    func render() -> [SubMeshType: Path] {
      let rect = CGRect(x:  -pivotPointSize / 2,
                        y:  -pivotPointSize / 2,
                        width: pivotPointSize,
                        height: pivotPointSize)
      var path = Path(ellipseIn: rect)
      path.closeSubpath()
      return [.pivotPoint: path]
    }
  }
}
