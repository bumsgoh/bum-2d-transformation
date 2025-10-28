//
//  RenderingView.swift
//  transformation
//
//  Created by 신갈엔진맨 on 10/28/25.
//

import SwiftUI

struct RenderingView: View {
  @ObservedObject private var scene: Graphics.Scene
  private var currentTime: TimeInterval = Date().timeIntervalSince1970
  @State var renderer = Graphics.Renderer()
  
  init(scene: Graphics.Scene) {
    self.scene = scene
  }
  
  var body: some View {
    GeometryReader { reader in
      ZStack {
        AxesView()
        renderingLayer
      }
    }
  }
  
  var renderingLayer: some View {
    Canvas { context, size in
      renderer.setViewport(size)
      renderer.render(scene: scene, in: &context)
    }
  }
}
