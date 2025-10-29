//
//  EditView.swift
//  transformation
//
//  Created by 신갈엔진맨 on 10/28/25.
//

//AI: Cursor 사용 UI 구현
//Prompt: 이미지 참고해서 SwiftUI로 오른쪽 툴바 UI 구현

import SwiftUI

struct EditView: View {
  private let onTap: (() -> Void)?
  
  @State private var positionX: Double = 0.0
  @State private var positionY: Double = 0.0
  @State private var rotation: Double = 0.0
  @State private var originX: Double = 0.0
  @State private var originY: Double = 0.0
  
  @ObservedObject var scene: Graphics.Scene
  
  init(scene: Graphics.Scene,
       onTap: (() -> Void)?) {
    self.scene = scene
    self.onTap = onTap
  }
  
  var body: some View {
    VStack(spacing: 20) {
      // 제목
      Text("Transform")
        .font(.title2)
        .fontWeight(.bold)
        .foregroundColor(.secondary)
      
      Divider()
      
      // 점의 좌표 섹션
      VStack(alignment: .leading, spacing: 8) {
        Text("점의 좌표")
          .font(.headline)
          .foregroundColor(.primary)
        
        VStack(alignment: .leading, spacing: 4) {
          if let s = scene.currentSelectedObject, let currentRect = s as? Graphics.Rectangle {
            PointRow(label: "Left-Top",
                     x: currentRect.worldLeftTop.x,
                     y: currentRect.worldLeftTop.y)
            PointRow(label: "Right-Top",
                     x: currentRect.worldRightTop.x,
                     y: currentRect.worldRightTop.y)
            PointRow(label: "Right-Bottom",
                     x: currentRect.worldRightBottom.x,
                     y: currentRect.worldRightBottom.y)
            PointRow(label: "Left-Bottom",
                     x: currentRect.worldLeftBottom.x,
                     y: currentRect.worldLeftBottom.y)
          }
        }
        .padding(.vertical, 4)
      }
      
      Divider()
      
      // 위치 섹션
      VStack(alignment: .leading, spacing: 8) {
        Text("위치")
          .font(.headline)
          .foregroundColor(.primary)
        
        HStack(spacing: 12) {
          NumberInputField(label: "X", value: $positionX)
          NumberInputField(label: "Y", value: $positionY)
        }
      }
      
      Divider()
      
      // 회전 섹션
      VStack(alignment: .leading, spacing: 8) {
        Text("회전")
          .font(.headline)
          .foregroundColor(.primary)
        
        NumberInputField(label: "", value: $rotation, isFullWidth: true)
      }
      
      Divider()
      
      // 원점 섹션
      VStack(alignment: .leading, spacing: 8) {
        Text("원점")
          .font(.headline)
          .foregroundColor(.primary)
        
        HStack(spacing: 12) {
          NumberInputField(label: "X", value: $originX)
          NumberInputField(label: "Y", value: $originY)
        }
      }
      
      Spacer()
      
      // 적용 버튼
      Button(action: {
        applyTransform()
      }) {
        Text("적용")
          .font(.headline)
          .foregroundColor(.white)
          .frame(maxWidth: .infinity)
          .frame(height: 52)
          .background(Color.blue)
          .cornerRadius(8)
      }
      .buttonStyle(ScaleButtonStyle())
    }
    .padding(16)
    .cornerRadius(12)
    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
  }
  
  private func applyTransform() {
    print("위치: (\(positionX), \(positionY))")
    print("회전: \(rotation)")
    print("원점: (\(originX), \(originY))")
    
    if let target = scene.currentSelectedObject {
      target.pivot = .init(x: originX, y: originY)
      target.position = .init(x: positionX, y: positionY)
      target.rotation = rotation
      onTap?()
    }
  }
}

// MARK: - Point Row Component

struct PointRow: View {
  let label: String
  let x: CGFloat
  let y: CGFloat
  
  var body: some View {
    HStack {
      Text(label)
        .font(.system(size: 13))
        .foregroundColor(.secondary)
        .frame(width: 90, alignment: .leading)
      
      Spacer()
      
      Text("\(Graphics.format(v: x, fraction: 2)), \(Graphics.format(v: y, fraction: 2))")
        .font(.system(size: 13, design: .monospaced))
        .foregroundColor(.primary)
    }
  }
}

// MARK: - Number Input Field Component

struct NumberInputField: View {
  let label: String
  @Binding var value: Double
  var isFullWidth: Bool = false
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      if !label.isEmpty {
        Text(label)
          .font(.caption)
          .foregroundColor(.secondary)
      }
      TextField("0.00", value: $value, format: .number.precision(.fractionLength(2)))
        .textFieldStyle(.roundedBorder)
    }
    .frame(maxWidth: isFullWidth ? .infinity : nil)
  }
}

struct ScaleButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
      .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
  }
}
