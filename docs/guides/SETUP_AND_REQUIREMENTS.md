# SlimeTest/Emergence Engine - Setup & Requirements
**ᚨᛉᛇᚲ::SETUP::ᛈᛖᚱᚦ**
**Date:** 2025-11-17
**Branch:** sparklization
**Status:** Active Development

---

## 🎯 Project Overview

**SlimeTest** (aka **Emergence Engine**, aka **Primal Essence Engine**) is a browser-based simulation exploring emergent behavior in intelligent agent swarms using reinforcement learning.

**Core Technology:**
- **Runtime:** Node.js v18.19.1, npm 9.2.0
- **Build Tool:** Vite 4.5.0
- **Graphics:** PixiJS 7.4.3
- **Language:** JavaScript ES6+ modules
- **Development:** Three parallel versions for comparison/experimentation

---

## 📋 System Requirements

### Software Dependencies

**Required:**
- Node.js >= 18.x
- npm >= 9.x
- Modern browser (Chrome, Firefox, Brave)
- Git (for version control)

**Optional:**
- Python 3.10+ (for launcher UI scripts)
- rclone (for Google Drive sync)
- Firebase CLI (for deployment)

**Installation Check:**
```bash
node --version    # Should show v18.19.1 or higher
npm --version     # Should show 9.2.0 or higher
git --version     # Any recent version
```

### Hardware Requirements

**Minimum:**
- RAM: 4GB (simulation runs in browser)
- Disk: 500MB for project + dependencies
- Display: 1280x720 (responsive design scales)

**Recommended:**
- RAM: 8GB (for comfortable development)
- Disk: 2GB free (for builds, caches, logs)
- Display: 1920x1080 or higher

---

## 🚀 Quick Start

### 1. Clone Repository
```bash
cd ~/pandora
git clone <repository-url> slimetest
cd slimetest
```

### 2. Install Dependencies
```bash
npm install
```

**Expected output:**
- node_modules/ directory created
- package-lock.json generated
- PixiJS and Vite installed

### 3. Choose Your Version

**Three versions available:**

| Port | Version | Purpose | Command |
|------|---------|---------|---------|
| 2000 | Original | Baseline for comparison | `npm run original` |
| 3000 | Primal | Sparkization enhancements | `npm run primal` |
| 4000 | Experimental | Active design development | `npm run experimental` |

### 4. Launch Development Server

**Option A: npm commands**
```bash
npm run primal          # Port 3000 (recommended)
npm run experimental    # Port 4000 (for design work)
npm run original        # Port 2000 (baseline)
```

**Option B: Bash aliases** (if configured)
```bash
primal                  # Port 3000
experimental            # Port 4000
original                # Port 2000
```

### 5. Access in Browser

Vite will auto-open browser to:
- `http://localhost:2000` (Original)
- `http://localhost:3000` (Primal)
- `http://localhost:4000` (Experimental)

---

## 📁 Project Structure

```
slimetest/
├── index.html                    # Active HTML (auto-swapped by launch scripts)
├── index_original.html           # Baseline version HTML
├── index_primal.html             # Primal Essence version HTML
├── index_experimental.html       # Experimental design HTML
│
├── app.js                        # Main application entry (87K)
├── config.js                     # Simulation configuration (87K)
├── package.json                  # npm configuration
│
├── vite.config.js                # Default Vite config
├── vite.config.port2000.js       # Original baseline config
├── vite.config.port3000.js       # Primal config
├── vite.config.port4000.js       # Experimental config
│
├── scripts/
│   ├── launch-original.sh        # Port 2000 launcher
│   ├── launch-primal.sh          # Port 3000 launcher
│   └── launch-experimental.sh    # Port 4000 launcher
│
├── src/                          # Source code modules
│   ├── core/                     # Core simulation systems
│   ├── systems/                  # Behavior systems
│   └── ui/                       # UI components
│
├── docs/                         # Documentation
│   ├── ONE_HERTZ_UI_FRAMEWORK.md # UI design philosophy
│   ├── SETUP_AND_REQUIREMENTS.md # This file
│   └── architecture/             # Technical docs
│
├── analysis/                     # Training analysis data
├── Past runs/                    # Archived training policies
├── node_modules/                 # Dependencies (npm install)
└── dist-*/                       # Build outputs
```

---

## 🎨 Version Differences

### Original (Port 2000)
- **Title:** "Essence Engine v0.01"
- **Hotkey Strip:** Standard contrast (11px font)
- **Style:** Vanilla baseline
- **Purpose:** Comparison reference

### Primal (Port 3000) - **Recommended**
- **Title:** "Primal Essence Engine v0.01"
- **Hotkey Strip:** Enhanced contrast (13px font, better opacity)
- **Metadata:** Runic signatures, reality anchors
- **Style:** Sparkization enhancements
- **Purpose:** Production-ready improvements

### Experimental (Port 4000)
- **Title:** TBD (currently same as Primal)
- **Style:** Active design experiments
- **Purpose:** Testing new UI/UX changes
- **Network:** Accessible from mobile (0.0.0.0 binding)

---

## 🔧 Configuration Files

### package.json Scripts

```json
{
  "scripts": {
    "original": "bash scripts/launch-original.sh",     // Port 2000
    "primal": "bash scripts/launch-primal.sh",         // Port 3000
    "experimental": "bash scripts/launch-experimental.sh", // Port 4000
    "build:original": "vite build --config vite.config.port2000.js",
    "build:primal": "vite build --config vite.config.port3000.js",
    "build:experimental": "vite build --config vite.config.port4000.js"
  }
}
```

### Launch Script Flow

Each launch script:
1. Copies appropriate HTML → `index.html`
2. Echoes confirmation message
3. Starts Vite on designated port

**Example: `scripts/launch-primal.sh`**
```bash
cp index_primal.html index.html
echo "✅ Activated: Primal Essence Engine"
vite --config vite.config.port3000.js
```

---

## 🔑 Bash Aliases

**Location:** `~/.bash_aliases`

**Installation:**
```bash
source ~/.bash_aliases    # Load in current session
```

**Available aliases:**
```bash
# Launchers
original            # Port 2000
primal              # Port 3000 (recommended)
experimental        # Port 4000
slime               # Port 3000 (alias for primal)

# Navigation
cdslime             # Jump to slimetest directory
cdpandora           # Jump to pandora root

# Google Drive
gdrive-status       # Check mount status
gdrive-mount        # Mount all drives
gdrive-unmount      # Unmount safely

# Utilities
breathe             # Clear + show location (grounding)
reset-slime         # Kill all + restart
ports               # Show listening ports
```

---

## 🌐 Google Drive Integration

### Setup

**Mount points:**
```
~/pandora/gdrive_mounts/
├── eaprime_prime_naught/    # Top-level backup
├── eaprime_pandora/         # Laptop sync folder
└── primeunexusi_root/       # Secondary account
```

**Commands:**
```bash
gdrive-mount        # Mount all three
gdrive-status       # Check status
gdrive-unmount      # Unmount before shutdown
```

### Synced Content

**In cloud:**
- `/slimetest/` folder with docs and HTML variants
- Training run policies (Past runs/)
- Documentation backups
- Conversation logs

**Auto-sync:** Not enabled (manual sync recommended)

---

## 🏗️ Building for Production

### Development Build

```bash
npm run build:primal              # Recommended
npm run build:experimental        # For testing
npm run build:original            # Baseline
```

**Output directories:**
- `dist-original/` → Port 2000 build
- `dist-primal/` → Port 3000 build
- `dist-experimental/` → Port 4000 build

### Firebase Deployment

**Prerequisites:**
```bash
npm install -g firebase-tools
firebase login
```

**Deploy:**
```bash
firebase deploy --only hosting
```

**Configuration:** See `firebase.json` (if exists)

---

## 🧪 Development Workflow

### Typical Session

1. **Start development server:**
   ```bash
   primal    # or: npm run primal
   ```

2. **Make changes:**
   - Edit `index_experimental.html` for UI experiments
   - Edit `app.js` for logic changes
   - Edit `config.js` for simulation parameters

3. **Hot reload:**
   - Vite watches files
   - Browser auto-refreshes on save

4. **Test across versions:**
   - Keep multiple ports running
   - Compare behavior side-by-side

5. **Commit changes:**
   ```bash
   git status
   git add .
   git commit -m "Description"
   git push origin sparklization
   ```

### Multi-Port Development

**Run all three simultaneously:**

**Terminal 1:**
```bash
npm run original    # Port 2000
```

**Terminal 2:**
```bash
npm run primal      # Port 3000
```

**Terminal 3:**
```bash
npm run experimental # Port 4000
```

**Benefits:**
- Side-by-side comparison
- Test responsiveness across versions
- Validate changes don't break baseline

---

## 🐛 Troubleshooting

### Port Already in Use

**Symptom:** `Error: listen EADDRINUSE`

**Solution:**
```bash
# Find process on port
lsof -i :3000

# Kill specific port
pkill -f "vite.*3000"

# Or kill all node processes
killnode    # (if alias configured)
```

### Dependencies Not Found

**Symptom:** `Cannot find module 'pixi.js'`

**Solution:**
```bash
rm -rf node_modules package-lock.json
npm install
```

### HTML Not Updating

**Symptom:** Changes don't appear in browser

**Possible causes:**
1. **Wrong HTML active** → Launch script swaps HTML
2. **Browser cache** → Hard refresh (Ctrl+Shift+R)
3. **Vite not watching** → Check terminal for errors

**Solution:**
```bash
# Re-run launch script
npm run primal

# Clear browser cache
# Hard refresh in browser
```

### Google Drive Not Mounting

**Symptom:** Mount points empty

**Solution:**
```bash
# Check rclone config
rclone config show

# Test connection
rclone lsd gdrive:

# Remount
gdrive-unmount
gdrive-mount
```

---

## 📚 Documentation Index

**Core docs:**
- `README.md` → Project overview
- `SETUP_AND_REQUIREMENTS.md` → This file
- `ONE_HERTZ_UI_FRAMEWORK.md` → UI philosophy & patterns

**Technical docs:**
- `docs/architecture/` → System architecture
- `docs/how-to/` → Guides and tutorials
- `GITHUB_PROJECT_STRUCTURE.md` → Detailed file map

**Development docs:**
- `ITERATION_NOTES.md` → Session notes
- `CURRENT_SETUP.md` → Environment status
- `Future Directions.md` → Roadmap

---

## 🔐 Environment Variables

**None currently required.**

**Future considerations:**
- `FIREBASE_TOKEN` → CI/CD deployment
- `GDRIVE_CLIENT_ID` → OAuth configuration
- `API_KEYS` → External service integration

---

## 🎯 Next Steps After Setup

### For Users
1. Launch `primal` version (recommended)
2. Explore simulation with hotkeys
3. Try training UI (press `L`)
4. Experiment with config panel (press `O`)

### For Developers
1. Review `ONE_HERTZ_UI_FRAMEWORK.md`
2. Launch `experimental` version
3. Make UI changes in `index_experimental.html`
4. Test with `npm run experimental`
5. Compare against `primal` baseline

### For Contributors
1. Fork repository
2. Create feature branch
3. Make changes
4. Test across all three versions
5. Submit pull request

---

## 📞 Support & Resources

**Repository:** (GitHub URL)
**Documentation:** `docs/` directory
**Issues:** GitHub Issues
**Questions:** Check docs first, then ask

---

## ✨ Quick Reference Card

```bash
# Start servers
primal              # Port 3000 (recommended)
experimental        # Port 4000 (design work)
original            # Port 2000 (baseline)

# Navigate
cdslime             # Jump to project
cdgdrive            # Jump to cloud mounts

# Manage
gdrive-status       # Check cloud
ports               # Show listening ports
reset-slime         # Restart everything

# When overwhelmed
breathe             # Ground yourself
```

---

**ᚨᛉᛇᚲ::SETUP::ᛈᛖᚱᚦ**
**∰◊€π¿🌌∞**

*One hertz. One mission. Ready to build.*

**Last Updated:** 2025-11-17
**Status:** Complete and tested
