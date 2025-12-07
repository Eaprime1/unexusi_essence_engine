#!/bin/bash
# ∰◊€π¿🌌∞ Server Setup Entity
# ONE MISSION: Configure optimal server environment for file movement

echo "🚀 SERVER SETUP ENTITY ACTIVATED"
echo "================================"

# Check current server capabilities
echo "🔍 Analyzing current server capabilities..."

# SSH Server Setup
if command -v sshd >/dev/null 2>&1; then
    echo "✅ SSH server available"
    sudo systemctl status ssh || systemctl status sshd 2>/dev/null | head -3
else
    echo "📦 Installing SSH server..."
    sudo apt update && sudo apt install -y openssh-server
fi

# File Transfer Tools
echo ""
echo "📁 File Transfer Tool Analysis:"
for tool in rsync scp sftp rclone; do
    if command -v "$tool" >/dev/null 2>&1; then
        echo "  ✅ $tool: $(which $tool)"
    else
        echo "  ❌ $tool: Not installed"
    fi
done

# Network File Sharing
echo ""
echo "🌐 Network Sharing Capabilities:"
for service in nfs-kernel-server samba; do
    if dpkg -l | grep -q "$service"; then
        echo "  ✅ $service: Installed"
    else
        echo "  📦 $service: Available for installation"
    fi
done

# Port Analysis
echo ""
echo "🔌 Network Port Status:"
netstat -tuln 2>/dev/null | grep -E ':22|:80|:443|:21|:873' || echo "  Port scanning not available"

# Generate server setup recommendations
cat > "$HOME/universe_logs/server_recommendations.txt" << 'RECOMMENDATIONS_EOF'
Server Setup Recommendations
============================

1. SSH Access Setup:
   - Enable SSH: sudo systemctl enable ssh
   - Configure firewall: sudo ufw allow 22
   - Generate SSH keys: ssh-keygen -t rsa -b 4096

2. File Transfer Optimization:
   - Install rclone for cloud storage: curl https://rclone.org/install.sh | sudo bash
   - Setup rsync for fast local transfers
   - Configure SFTP for secure file access

3. Multi-Location File Movement:
   - Use rclone to mount all cloud storage accounts
   - Setup automatic sync with rsync + cron
   - Create backup strategies across locations

4. Security Considerations:
   - Change default SSH port
   - Use key-based authentication only
   - Setup fail2ban for intrusion prevention
   - Regular security updates

RECOMMENDATIONS_EOF

echo "📋 Server recommendations saved to ~/universe_logs/server_recommendations.txt"
echo "✅ Server Setup Entity Mission Complete"
