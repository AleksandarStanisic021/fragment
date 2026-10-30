import * as THREE from "three";
import { OrbitControls } from "three/addons/controls/OrbitControls.js";
import cubeFragmentShader from "./shaders/cube.frag.glsl?raw";
import cubeVertexShader from "./shaders/cube.vert.glsl?raw";
import "./style.css";

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(
  50,
  window.innerWidth / window.innerHeight,
  0.1,
  100,
);
camera.position.set(0, 0, 12);

const renderer = new THREE.WebGLRenderer({ antialias: true });
renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.outputColorSpace = THREE.SRGBColorSpace;
const mount = document.querySelector<HTMLElement>("#scene");

if (!mount) {
  throw new Error('Scene mount element "#scene" was not found.');
}

mount.appendChild(renderer.domElement);

const ambientLight = new THREE.AmbientLight(0xffffff, 0.45);
const directionalLight = new THREE.DirectionalLight(0xffffff, 1.7);
directionalLight.position.set(4, 5, 6);
scene.add(ambientLight, directionalLight);

const material = new THREE.ShaderMaterial({
  uniforms: {
    uDiffuseColor: { value: new THREE.Color("#1f6fff") },
    uAmbientLightColor: {
      value: ambientLight.color,
    },
    uDirectionalLightColor: {
      value: directionalLight.color,
    },
    uDirectionalLightDirection: {
      value: directionalLight.position.clone().normalize(),
    },
    time: { value: 0.0 },
  },
  vertexShader: cubeVertexShader,
  fragmentShader: cubeFragmentShader,
});

const mesh = new THREE.Mesh(new THREE.SphereGeometry(2.6, 64, 64), material);
scene.add(mesh);

const controls = new OrbitControls(camera, renderer.domElement);
controls.addEventListener("change", render);

function render() {
  renderer.render(scene, camera);
}

function resize() {
  const width = window.innerWidth;
  const height = window.innerHeight;

  camera.aspect = width / height;
  camera.updateProjectionMatrix();

  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
  renderer.setSize(width, height);
  render();
}

function animateFrame(timeMs: number) {
  const time = timeMs * 0.001;

  material.uniforms.time.value = time;
  mesh.rotation.y = time * 0.6;
  mesh.rotation.x = time * 0.35;
  render();
  requestAnimationFrame(animateFrame);
}

requestAnimationFrame(animateFrame);
window.addEventListener("resize", resize);
render();
