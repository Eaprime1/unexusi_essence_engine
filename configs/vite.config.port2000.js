// vite.config.port2000.js - Original Baseline Version
// Pure vanilla Essence Engine for comparison
// ᚨᛉᛇᚲ::BASELINE::ᛈᛖᚱᚦ

import { defineConfig } from 'vite';

export default defineConfig({
  server: {
    port: 2000,
    open: true,
    host: '127.0.0.1'  // Localhost only
  },
  build: {
    target: 'esnext',
    outDir: 'dist-original',
    sourcemap: true
  },
  optimizeDeps: {
    include: ['pixi.js']
  }
});
