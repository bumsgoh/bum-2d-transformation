//
//  AxesView.swift
//  transformation
//
//  Created by 신갈엔진맨 on 10/28/25.
//

import SwiftUI

struct AxesView: View {
  private let tickSpacing: CGFloat = 10
  private let centerPointSize: CGFloat = 6
  
  
  
  //Center Point를 기준으로 그리드와 axis를 그린다.
  var body: some View {
    Canvas { context, size in
      let centerPoint = CGPoint(x: Graphics.centerPixel(size.width / 2),
                                y: Graphics.centerPixel(size.height / 2))
      var path = Path()
      var pos: CGFloat = centerPoint.x
      while pos <  size.width {
        path.move(to: CGPoint(x: pos, y: .zero))
        path.addLine(to: CGPoint(x: pos, y: size.height))
        pos += tickSpacing
      }
      pos = centerPoint.x
      while pos >  0 {
        path.move(to: CGPoint(x: pos, y: .zero))
        path.addLine(to: CGPoint(x: pos, y: size.height))
        pos -= tickSpacing
      }
      
      pos = centerPoint.y
      while pos < size.height {
        path.move(to: CGPoint(x: .zero, y: pos))
        path.addLine(to: CGPoint(x: size.width, y: pos))
        pos += tickSpacing
      }
      
      pos = centerPoint.y
      while pos > 0 {
        path.move(to: CGPoint(x: .zero, y: pos))
        path.addLine(to: CGPoint(x: size.width, y: pos))
        pos -= tickSpacing
      }
      
      context.stroke(path,
                     with: .color(.black.opacity(0.1)),
                     style: StrokeStyle(lineWidth: 1, lineCap: .square))
      
      path = Path()
      path.move(to: CGPoint(x: centerPoint.x, y: centerPoint.y))
      path.addLine(to: CGPoint(x: size.width, y: centerPoint.y))
      
      path.move(to: CGPoint(x: centerPoint.x, y: centerPoint.y))
      path.addLine(to: CGPoint(x: 0, y: centerPoint.y))
      
      path.move(to: CGPoint(x: centerPoint.x, y: centerPoint.y))
      path.addLine(to: CGPoint(x: centerPoint.x, y: 0))
      
      path.move(to: CGPoint(x: centerPoint.x, y: centerPoint.y))
      path.addLine(to: CGPoint(x: centerPoint.x, y: size.height))
      
      context.stroke(path, with: .color(.black), lineWidth: 1)
      
      let rect = CGRect(x: centerPoint.x - centerPointSize / 2,
                        y: centerPoint.y - centerPointSize / 2,
                        width: centerPointSize,
                        height: centerPointSize)
      context.fill(Path(ellipseIn: rect), with: .color(.blue))
    }
  }
}
