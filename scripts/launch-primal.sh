#!/bin/bash
# Launch Primal Essence Version on Port 3000
# ᚨᛉᛇᚲ::PRIMAL::ᛈᛖᚱᚦ

cd "$(dirname "$0")/.."
cp variants/index_primal.html index.html
echo "✅ Activated: Primal Essence Engine (Sparkization)"
echo "🚀 Starting on Port 3000..."
vite --config configs/vite.config.port3000.js
