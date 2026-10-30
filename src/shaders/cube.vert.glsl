varying vec3 vNormal;
varying vec3 vPosition;

uniform float time;


mat3 rotateY(float angle) {
  float c = cos(angle);
  float s = sin(angle);
  return mat3(
    c, 0.0, -s,
    0.0, 1.0, 0.0,
    s, 0.0, c
  );
}

void main() {
  vec3 localSpacePosition = position;

  float waveY = sin(time * 5.8);

  localSpacePosition = rotateY(time) * localSpacePosition;
  localSpacePosition.y += waveY;
  

  vNormal = normalize(mat3(modelMatrix) * normal);
  vPosition = vec3(modelMatrix * vec4(localSpacePosition, 1.0));
  gl_Position = projectionMatrix * modelViewMatrix * vec4(localSpacePosition, 1.0);
}

