//
//  Scene.swift
//  transformation
//
//  Created by 신갈엔진맨 on 10/28/25.
//
import Foundation
import Combine

extension Graphics {
  class Scene: ObservableObject {
    @Published var currentSelectedObject: Shape?
    
    var objects: [Shape] = []
    
    func add(_ object: Shape) {
      objects.append(object)
    }
    
    func update() {
      objectWillChange.send()
    }
  }
}
