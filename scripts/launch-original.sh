#!/bin/bash
# Launch Original Baseline Version on Port 2000
# ᚨᛉᛇᚲ::BASELINE::ᛈᛖᚱᚦ

cd "$(dirname "$0")/.."
cp variants/index_original.html index.html
echo "✅ Activated: Original Baseline (Essence Engine)"
echo "🚀 Starting on Port 2000..."
vite --config configs/vite.config.port2000.js
