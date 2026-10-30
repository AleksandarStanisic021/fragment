varying vec3 vNormal;
varying vec3 vPosition;
varying vec3 vColor;

uniform float time;

void main() {
  vec3 localSpacePosition = position;



  vec4 worldPosition = modelMatrix * vec4(localSpacePosition, 1.0);

  vNormal = normalize(mat3(modelMatrix) * normal);
  vPosition = worldPosition.xyz;
  vColor = vec3(0.12, 0.43, 1.0);

  gl_Position = projectionMatrix * modelViewMatrix * vec4(localSpacePosition, 1.0);
}

