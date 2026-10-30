varying vec3 vNormal;
varying vec3 vPosition;

void main() {
  vec3 localSpacePosition = position;

  vNormal = normalize(mat3(modelMatrix) * normal);
  vPosition = vec3(modelMatrix * vec4(localSpacePosition, 1.0));
  gl_Position = projectionMatrix * modelViewMatrix * vec4(localSpacePosition, 1.0);
}
    