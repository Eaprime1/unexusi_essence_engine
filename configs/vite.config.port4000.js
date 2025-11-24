// vite.config.port4000.js - Experimental Design Version
// Active development for design changes
// ᚨᛉᛇᚲ::EXPERIMENTAL::ᛈᛖᚱᚦ

import { defineConfig } from 'vite';

export default defineConfig({
  server: {
    port: 4000,
    open: true,
    host: '0.0.0.0'  // Network accessible for mobile testing
  },
  build: {
    target: 'esnext',
    outDir: 'dist-experimental',
    sourcemap: true
  },
  optimizeDeps: {
    include: ['pixi.js']
  }
});
