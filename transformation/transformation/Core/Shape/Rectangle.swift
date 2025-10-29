//
//  Rectangle.swift
//  transformation
//
//  Created by 신갈엔진맨 on 10/28/25.
//
import Foundation
import CoreGraphics
import SwiftUI

extension Graphics {
  final class Rectangle: Shape {
    private let leftTop: CGPoint
    private let rightTop: CGPoint
    private let leftBottom: CGPoint
    private let rightBottom: CGPoint
  
    var worldLeftTop: CGPoint {
      leftTop.applying(worldTransform)
    }
    var worldRightTop: CGPoint {
      rightTop.applying(worldTransform)
    }
    var worldLeftBottom: CGPoint {
      leftBottom.applying(worldTransform)
    }
    var worldRightBottom: CGPoint {
      rightBottom.applying(worldTransform)
    }
    
    init(leftTop: CGPoint,
         rightTop: CGPoint,
         leftBottom: CGPoint,
         rightBottom: CGPoint) {
      self.leftTop = leftTop
      self.rightTop = rightTop
      self.leftBottom = leftBottom
      self.rightBottom = rightBottom
      
      super.init()
      self.material[.body] = .init(color: .gray, lineColor: .black, lineWidth: 1)
      //사각형 스펙: 회색배경, 검은색 라인
    }
    
    //부모에서 그린 pivot과 자신의 path를 합쳐서 리턴
    override func render() -> [SubMeshType: Path] {
      var data = super.render()
      
      var line = Path()
      line.move(to: leftBottom)
      line.addLine(to: leftTop)
      line.addLine(to: rightTop)
      line.addLine(to: rightBottom)
      line.closeSubpath()
      
      data[.body] = line
      return data
      
    }
  }
}
