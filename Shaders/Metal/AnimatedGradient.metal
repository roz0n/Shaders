//
//  Shader.metal
//  Geronimo
//
//  Created by Arnaldo Rozon on 5/13/25.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 animatedGradient(float2 position, float2 size, float time) {
  float2 uv = position / size;
  
  float wave = sin((uv.x * 10.0 + time));
  float brightness = 0.5 + 0.5 * wave;
  
  return half4(brightness, brightness * 0.5, 1.0 - brightness, 1.0);
}
