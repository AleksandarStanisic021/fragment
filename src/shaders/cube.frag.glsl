uniform vec3 uAmbientLightColor;
uniform vec3 uDirectionalLightColor;
uniform vec3 uDirectionalLightDirection;
varying vec3 vNormal;

void main() {
  vec3 baseColor = vec3(0.22, 0.72, 0.92);
  float diffuse = max(dot(normalize(vNormal), normalize(uDirectionalLightDirection)), 0.0);
  vec3 lighting = uAmbientLightColor + uDirectionalLightColor * diffuse;

  gl_FragColor = vec4(baseColor * lighting, 1.0);
  #include <tonemapping_fragment>
  #include <colorspace_fragment>
}
