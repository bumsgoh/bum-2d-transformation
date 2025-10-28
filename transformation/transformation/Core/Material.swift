//
//  Material.swift
//  transformation
//
//  Created by 신갈엔진맨 on 10/28/25.
//

import Foundation
import CoreGraphics
import SwiftUI

extension Graphics {
  class Material {
    let color: Color
    let lineWidth: CGFloat
    let lineColor: Color
    
    init(color: Color = .gray,
         lineColor: Color = .black,
         lineWidth: CGFloat = 1) {
      self.color = color
      self.lineColor = lineColor
      self.lineWidth = lineWidth
    }
  }
}
