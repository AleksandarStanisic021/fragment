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

const ambientLight = new THREE.AmbientLight(0xffffff, 0.5);
const directionalLight = new THREE.DirectionalLight(0xffffff, 1.5);
directionalLight.position.set(4, 5, 6);
scene.add(ambientLight, directionalLight);

const cubeMaterial = new THREE.ShaderMaterial({
  uniforms: {
    uDiffuseColor: { value: new THREE.Color("#f44222") },
    uAmbientLightColor: {
      value: ambientLight.color,
    },
    uDirectionalLightColor: {
      value: directionalLight.color,
    },
    uDirectionalLightDirection: {
      value: directionalLight.position.clone().normalize(),
    },
  },
  vertexShader: cubeVertexShader,
  fragmentShader: cubeFragmentShader,
});

const cube = new THREE.Mesh(new THREE.BoxGeometry(5, 5, 5), cubeMaterial);
scene.add(cube);

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

window.addEventListener("resize", resize);
render();
