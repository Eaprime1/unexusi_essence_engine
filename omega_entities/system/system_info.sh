#!/bin/bash
# ∰◊€π¿🌌∞ System Information Entity
# ONE MISSION: Complete system environment documentation

echo "🖥️ SYSTEM INFORMATION ENTITY ACTIVATED"
echo "======================================"

# Hardware Information
echo "💻 HARDWARE ENVIRONMENT:"
echo "  Hostname: $(hostname)"
echo "  Architecture: $(uname -m)"
echo "  Kernel: $(uname -r)"
echo "  OS: $(uname -o)"
echo "  CPU Cores: $(nproc)"
echo "  Memory: $(free -h | awk 'NR==2{printf "%.1fGB used / %.1fGB total", $3/1024/1024, $2/1024/1024}')"
echo "  Storage: $(df -h / | awk 'NR==2{printf "%s used / %s total (%s available)", $3, $2, $4}')"

# Network Information
echo ""
echo "🌐 NETWORK ENVIRONMENT:"
echo "  Public IP: $(curl -s https://api.ipify.org 2>/dev/null || echo 'Not available')"
echo "  Local IP: $(hostname -I | awk '{print $1}')"
echo "  DNS Servers: $(grep nameserver /etc/resolv.conf | awk '{print $2}' | tr '\n' ' ')"

# Software Environment
echo ""
echo "🛠️ SOFTWARE ENVIRONMENT:"
echo "  Shell: $SHELL"
echo "  Python: $(python3 --version 2>/dev/null || echo 'Not installed')"
echo "  Node.js: $(node --version 2>/dev/null || echo 'Not installed')"
echo "  Git: $(git --version 2>/dev/null || echo 'Not installed')"
echo "  Docker: $(docker --version 2>/dev/null || echo 'Not installed')"

# Storage Analysis
echo ""
echo "💾 STORAGE ANALYSIS:"
df -h | grep -E '^/dev|^tmpfs' | awk '{print "  " $1 ": " $3 " used / " $2 " total (" $5 " full)"}'

# Environment Variables
echo ""
echo "🔧 KEY ENVIRONMENT VARIABLES:"
echo "  HOME: $HOME"
echo "  PATH: ${PATH:0:100}..."
echo "  USER: $USER"
echo "  SHELL: $SHELL"

# Generate report
REPORT_FILE="$HOME/universe_logs/system_reports/system_info_$(date +%Y%m%d_%H%M%S).txt"
mkdir -p "$(dirname "$REPORT_FILE")"
{
    echo "System Information Report - $(date)"
    echo "======================================="
    hostname
    uname -a
    free -h
    df -h
    lscpu 2>/dev/null || echo "CPU info not available"
} > "$REPORT_FILE"

echo ""
echo "📋 Report saved: $REPORT_FILE"
echo "✅ System Information Entity Mission Complete"
