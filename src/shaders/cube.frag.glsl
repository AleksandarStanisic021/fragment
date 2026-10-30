uniform vec3 uDiffuseColor;
uniform vec3 uAmbientLightColor;
uniform vec3 uDirectionalLightColor;
uniform vec3 uDirectionalLightDirection;
varying vec3 vNormal;
varying vec3 vPosition;
varying vec3 vColor;

void main() {
  vec3 normal = normalize(vNormal);
  float diffuse = max(dot(normal, normalize(uDirectionalLightDirection)), 0.0);
  vec3 lighting = uAmbientLightColor + uDirectionalLightColor * diffuse;

  vec3 color = vColor * lighting;

  gl_FragColor = vec4(color, 1.0);

  #include <tonemapping_fragment>
  #include <colorspace_fragment>
}
