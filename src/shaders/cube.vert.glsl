varying vec3 vNormal;
varying vec3 vPosition;
varying vec3 vColor;

uniform float time;

void main() {
  vec3 pos = position;
  float wave = sin(time * 2.0 + position.y * 6.0) * 0.2;
  pos += normal * wave;

  vec4 worldPosition = modelMatrix * vec4(pos, 1.0);

  vNormal = normalize(mat3(modelMatrix) * normal);
  vPosition = worldPosition.xyz;
  vColor = vec3(0.12, 0.43, 1.0);

  gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

