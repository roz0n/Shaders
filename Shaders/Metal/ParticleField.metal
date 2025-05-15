//
//  ParticleField.metal
//  Geronimo
//
//  Created by Arnaldo Rozon on 5/15/25.
//

#include <metal_stdlib>
#include "ShaderUtils.metal"

using namespace metal;

[[ stitchable ]] half4 particleField(float2 position, float2 size, float time) {
  float2 uv = position / size;
  uv = uv * 2.0 - 1.0; // center [-1, 1]
  
  float intensity = 0.0;
  
  for (int i = -2; i <= 2; i++) {
    for (int j = -4; j <= 4; j++) {
      float2 center = float2(i, j) * 0.5;
      float2 offset = uv - center;
      
      float dist = length(offset);
      float pulse = 0.25 / (dist + 0.05) * sin(10.0 * dist - time * 3.0);
      intensity += pulse;
    }
  }
  
  intensity = clamp(intensity, 0.0, 1.0);
  
  float hue = fmod(time * 0.35 + length(uv) * 0.5, 1.0);
  float3 color = hsv_to_rgb(float3(hue, 1.0, intensity));
  
  return half4(color.r, color.g, color.b, 1.0);
}
