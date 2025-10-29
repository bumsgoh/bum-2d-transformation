//
//  Renderer.swift
//  transformation
//
//  Created by 신갈엔진맨 on 10/28/25.
//
import Foundation
import CoreGraphics
import SwiftUI

extension Graphics {
  class Renderer {
    private var viewPortTransform: CGAffineTransform = .identity
    
    func setViewport(_ viewport: CGSize) {
      var transform = CGAffineTransform.identity
      transform = transform.translatedBy(
        x: centerPixel(viewport.width / 2),
        y:centerPixel(viewport.height / 2)
      )
      transform = transform.scaledBy(x: 1, y: -1)
      viewPortTransform = transform
    }
    
    func render(scene: Scene, in context: inout GraphicsContext) {
      for object in scene.objects {
        let data = object.render()
        //pivot이 항상 맨위에 그려지기 위해 sorting
        data.keys.sorted().forEach { key in
          if let material = object.material[key],
              let path = data[key] {
            switch key {
            case .body:
              //월드좌표(Translation, Rotation포함) * 뷰포트 좌표
            context.transform =  object.worldTransform.concatenating(viewPortTransform)
            context.stroke(path,
                             with: .color(material.lineColor),
                             lineWidth: material.lineWidth)
              context.fill(path, with: .color(material.color))
            case .pivotPoint:
              //월드좌표(Translation 포함) * 뷰포트 좌표, pivot은 위치만 옮겨지면 되므로 다른 변환은 필요없음
              context.transform = object.worldTranslation.concatenating(viewPortTransform)
              context.fill(path, with: .color(material.color))
            }
          }
        }
      }
    }
  }
}
