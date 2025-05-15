//
//  BlackHole.metal
//  Geronimo
//
//  Created by Arnaldo Rozon on 5/15/25.
//

#include <metal_stdlib>
#include "ShaderUtils.metal"

using namespace metal;

[[ stitchable ]] half4 blackHole(float2 position, float2 size, float time) {
  float2 uv = position / size;
  uv = uv * 2.0 - 1.0; // center [-1, 1]
  
  float dist = length(uv);
  float angle = atan2(uv.y, uv.x);
  
  // Vortex distortion
  float twist = 0.3 * sin(time + dist * 10.0);
  angle += twist;
  
  float2 swirlUV = float2(cos(angle), sin(angle)) * dist;
  
  float brightness = exp(-length(swirlUV) * 6.0);
  float ring = 0.2 * sin(40.0 * dist - time * 5.0);
  
  float glow = brightness + ring;
  float3 baseColor = hsv_to_rgb(float3(0.7 + 0.1 * sin(time * 0.5), 1.0, glow));
  
  return half4(baseColor.r, baseColor.g, baseColor.b, 1.0);
}
