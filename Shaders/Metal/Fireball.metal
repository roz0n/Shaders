//
//  Fireball.metal
//  Geronimo
//
//  Created by Arnaldo Rozon on 5/15/25.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 fireball(float2 position, float2 size, float time) {
  float2 uv = position / size;
  uv = uv * 2.0 - 1.0;
  
  float dist = length(uv);
  float angle = atan2(uv.y, uv.x);
  
  // Radial flame pulse + turbulence
  float radialWave = sin(10.0 * dist - time * 6.0) * 0.05;
  float angleDistort = sin(angle * 8.0 + time * 4.0) * 0.05;
  dist += radialWave + angleDistort;
  
  // Core intensity
  float flicker = 0.9 + 0.1 * sin(time * 15.0 + dist * 20.0);
  float intensity = exp(-dist * 6.0) * flicker;
  
  // Flame shape
  float shape = smoothstep(0.5, 0.0, dist);
  
  // Sparks (radial noise burst)
  float sparkPattern = sin(80.0 * angle + time * 20.0 + dist * 30.0);
  float sparks = smoothstep(0.95, 1.0, sparkPattern) * exp(-dist * 15.0);
  
  // Color blend
  float3 fireCore = float3(1.0, 1.0, 0.4); // bright core
  float3 fireEdge = float3(1.0, 0.2, 0.0); // ember glow
  float3 sparkColor = float3(1.0, 0.8, 0.6); // spark yellow
  
  float3 color = mix(fireEdge, fireCore, intensity);
  color += sparkColor * sparks;
  color *= shape;
  
  return half4(color.r, color.g, color.b, 1.0);
}
