// vite.config.port3000.js - Primal Essence Engine
// Sparkization branch with enhanced UI
// ᚨᛉᛇᚲ::PRIMAL::ᛈᛖᚱᚦ

import { defineConfig } from 'vite';

export default defineConfig({
  server: {
    port: 3000,
    open: true,
    host: '127.0.0.1'  // Localhost only
  },
  build: {
    target: 'esnext',
    outDir: 'dist-primal',
    sourcemap: true
  },
  optimizeDeps: {
    include: ['pixi.js']
  }
});
