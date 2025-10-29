//
//  ContentView.swift
//  transformation
//
//  Created by 신갈엔진맨 on 10/27/25.
//

import SwiftUI

struct ContentView: View {
  @State var scene = Graphics.Scene()
  
  init() {
    let rect =  Graphics.Rectangle(
      leftTop: .init(x: 0, y: 100),
      rightTop: .init(x: 100, y: 100),
      leftBottom: .init(x: 0, y: 0),
      rightBottom: .init(x: 100, y: 0))
    scene.add(rect)
    scene.currentSelectedObject = rect
  }
  
  var body: some View {
    HStack {
      RenderingView(scene: scene)
      EditView(scene: scene,
               onTap: {
        scene.update()
      })
      .frame(width: 300)
    }
  }
}

#Preview {
  ContentView()
}
