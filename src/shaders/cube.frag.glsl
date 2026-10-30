uniform vec3 uDiffuseColor;
uniform vec3 uAmbientLightColor;
uniform vec3 uDirectionalLightColor;
uniform vec3 uDirectionalLightDirection;
varying vec3 vNormal;
varying vec3 vColor;

void main() {
  vec3 normal = normalize(vNormal);
  vec3 lightDir = normalize(uDirectionalLightDirection);

  float diffuse = max(dot(normal, lightDir), 0.0);
  float shadow = 0.35 + diffuse * 0.65;

  vec3 baseColor = mix(vColor, uDiffuseColor, 0.35);
  vec3 lighting = uAmbientLightColor + uDirectionalLightColor * diffuse;
  vec3 color = baseColor * lighting * shadow;

  gl_FragColor = vec4(color, 1.0);

  #include <tonemapping_fragment>
  #include <colorspace_fragment>
}
