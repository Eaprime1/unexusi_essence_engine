#!/bin/bash
# Launch Experimental Design Version on Port 4000
# ᚨᛉᛇᚲ::EXPERIMENTAL::ᛈᛖᚱᚦ

cd "$(dirname "$0")/.."
cp variants/index_experimental.html index.html
echo "✅ Activated: Experimental Design Version"
echo "🚀 Starting on Port 4000..."
vite --config configs/vite.config.port4000.js
