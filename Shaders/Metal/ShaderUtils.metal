//
//  ShaderUtils.metal
//  Geronimo
//
//  Created by Arnaldo Rozon on 5/15/25.
//

#include <metal_stdlib>
using namespace metal;

static float3 hsv_to_rgb(float3 c) {
  float4 K = float4(1.0, 2.0/3.0, 1.0/3.0, 3.0);
  float3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
  
  return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}
