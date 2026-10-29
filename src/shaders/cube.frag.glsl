uniform vec3 uDiffuseColor;
uniform vec3 uAmbientLightColor;
uniform vec3 uDirectionalLightColor;
uniform vec3 uDirectionalLightDirection;
varying vec3 vNormal;

void main() {
  vec3 normal = normalize(vNormal);
  float diffuse = max(dot(normal, normalize(uDirectionalLightDirection)), 0.0);
  vec3 lighting = uAmbientLightColor + uDirectionalLightColor * diffuse;

  gl_FragColor = vec4( uDiffuseColor * lighting, 1.0);
  #include <tonemapping_fragment>
  #include <colorspace_fragment>
}
