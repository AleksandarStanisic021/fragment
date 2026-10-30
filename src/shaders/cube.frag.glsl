uniform vec3 uDiffuseColor;
uniform vec3 uAmbientLightColor;
uniform vec3 uDirectionalLightColor;
uniform vec3 uDirectionalLightDirection;
varying vec3 vNormal;
varying vec3 vPosition;
varying vec3 vColor;

void main() {
  vec3 normal = normalize(vNormal);
  vec3 lightDir = normalize(uDirectionalLightDirection);
  float diffuse = max(dot(normal, lightDir), 0.0);

  float shadowAmount = 0.25 + diffuse * 0.75;
  vec3 lighting = uAmbientLightColor + uDirectionalLightColor * diffuse;
  vec3 color = vColor * lighting * shadowAmount;

  gl_FragColor = vec4(color, 1.0);

  #include <tonemapping_fragment>
  #include <colorspace_fragment>
}
