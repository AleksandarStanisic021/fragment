/// <reference types="vite/client" />

declare module '*.css';

declare module '*.glsl?raw' {
  const source: string;
  export default source;
}
