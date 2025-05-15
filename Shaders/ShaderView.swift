//
//  ShaderView.swift
//  Shaders
//
//  Created by Arnaldo Rozon on 5/15/25.
//

import SwiftUI
import MetalKit

enum CustomShader {
  case gradient
  case particles
  case blackhole
  case fireball
  
  var name: String {
    switch self {
      case .gradient: "animatedGradient"
      case .particles: "particleField"
      case .blackhole: "blackHole"
      case .fireball: "fireball"
    }
  }
}

struct ShaderView: View {
  
  @State private var time: Float = 0
  
  var body: some View {
    Canvas(opaque: false, rendersAsynchronously: true) { canvasContext, size in
      let shader = Shader(
        function: ShaderFunction(library: .default,
                                 name: CustomShader.fireball.name),
        arguments: [
          .float2(Float(size.width), Float(size.height)),
          .float(time)
        ]
      )
      
      canvasContext.fill(
        Path(CGRect(origin: .zero, size: size)),
        with: .shader(shader)
      )
    }
    .ignoresSafeArea()
    .onAppear {
      Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { timer in
        time += 1.0 / 60.0
      }
    }
  }
  
}

#Preview {
  ShaderView()
}
