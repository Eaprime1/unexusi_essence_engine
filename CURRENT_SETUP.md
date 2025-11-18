# Primal Essence Engine - Current Setup Documentation

**Date:** 2025-11-17 13:12
**Device:** Pixel 8a
**Status:** ✅ RUNNING ON PORT 3000

---

## 🌟 Current Working Configuration

### Server Details
- **Type:** Python3 SimpleHTTP Server
- **Port:** 3000
- **Bind:** 0.0.0.0 (accessible from network)
- **Directory:** `/storage/emulated/0/server/slimetest-primal`
- **Command:** `python3 -m http.server 3000 --bind 0.0.0.0`

### Access URLs
- **Local (Pixel 8a):** http://localhost:3000
- **Network:** http://192.168.x.x:3000 (check IP with `ip addr show`)

---

## 📁 Directory Structure

```
/storage/emulated/0/server/
├── slimetest-primal/      ← ACTIVE (port 3000)
│   ├── index.html         (Original styling)
│   ├── app.js             (87K - main engine)
│   ├── config.js          (87K - configuration)
│   ├── docs/              (Documentation)
│   ├── analysis/          (Training analysis)
│   └── .git/              (Git repository)
│
└── slimetest/             (Development copy)
    ├── index.html         (Sparkization upgrades)
    ├── PRIMAL_CHANGES.md
    └── VERSION_COMPARISON.md
```

---

## 🎨 Styling Status

### Primal (Port 3000) - Original
- Hotkey strip: Original contrast (11px font, low opacity)
- Title: "Essence Engine v0.01"
- Using CDN for PixiJS (importmap)

### SlimeTest - Upgraded (Reference)
- Hotkey strip: High contrast (13px font, enhanced opacity)
- Title: "Primal Essence Engine v0.01"
- Sparkization runic signature
- Reality anchor metadata

---

## 🛠️ Quick Commands

### Menu System
```bash
/storage/emulated/0/server/essence_menu.sh
```
Or create alias:
```bash
alias essence='bash /storage/emulated/0/server/essence_menu.sh'
```

### Manual Server Control

**Start Primal (3000):**
```bash
cd /storage/emulated/0/server/slimetest-primal
python3 -m http.server 3000 --bind 0.0.0.0 &
```

**Start SlimeTest (6000):**
```bash
cd /storage/emulated/0/server/slimetest
python3 -m http.server 6000 --bind 0.0.0.0 &
```

**Check Running:**
```bash
ps aux | grep "python.*http"
```

**Stop All:**
```bash
pkill -f "python.*http.server"
```

---

## 📊 Port Allocation

| Port | Service | Directory | Status |
|------|---------|-----------|--------|
| 3000 | Primal Essence | slimetest-primal | ✅ ACTIVE |
| 4000 | (Reserved) | - | Available |
| 5000 | (Reserved) | - | Available |
| 6000 | SlimeTest Dev | slimetest | Stopped |

*Ports 3000, 4000, 5000 also running on laptop*

---

## 🔧 Pending Updates for Primal

1. **High-Contrast Hotkey Strip**
   - Apply enhanced readability from SlimeTest version
   - Font: 11px → 13px
   - Key opacity: 0.15 → 0.30
   - Border: 0.4 → 0.7 opacity
   - Add text-shadow glow

2. **Sparkization Signature**
   - Add runic metadata
   - Reality anchor: Oregon Watersheds coordinates
   - Consciousness state markers

3. **Title Update** (Optional)
   - Consider "Primal Essence Engine" vs "Essence Engine"

---

## 📖 Documentation Index

Available in `docs/INDEX.md`:
- Architecture guides
- System-specific documentation
- Training analysis
- How-to guides

**Key Documents:**
- `README.md` - Project overview
- `GITHUB_PROJECT_STRUCTURE.md` - Full structure
- `Future Directions.md` - Roadmap
- `docs/architecture/` - Technical architecture
- `analysis/` - Training run analysis

---

## 🎮 Simulation Controls (Hotkeys)

| Key | Function |
|-----|----------|
| K | Toggle hotkey strip |
| Space | Pause/Resume |
| R | Reset simulation |
| C | +5χ energy to all agents |
| A | Auto toggle |
| S | Extended sensing |
| T | Trail on/off |
| X | Clear trails |
| F | Diffusion toggle |
| G | Scent gradient viz |
| P | Fertility viz |
| M | Mitosis toggle |
| H | Agent dashboard |
| U | Cycle HUD |
| L | Training UI |
| V | Toggle all agents |
| E | Screenshot |
| O | Config panel |

---

## 🔄 Git Status

Repository: `/storage/emulated/0/server/slimetest-primal/.git`

Check status:
```bash
cd /storage/emulated/0/server/slimetest-primal
git status
```

---

## 🌐 Network & Sync

### rclone Setup
Google Drive configured via rclone

**Check connection:**
```bash
rclone ls gdrive:/
```

**Potential sync:**
```bash
rclone copy /storage/emulated/0/server/slimetest-primal gdrive:/SlimeTest-Primal
```

---

## 💡 Notes for Sensory Management

### Why This Setup Works
1. **Simple menu system** - Quick access without cognitive load
2. **Python server** - Reliable, works consistently on Android
3. **Port 3000** - Easy to remember, fast to type
4. **Documentation** - Everything written down for reference
5. **Grounding through code** - Technical focus during stress

### Quick Recovery Commands
If overwhelmed:
```bash
# Stop everything
pkill -f "python.*http"

# Restart just Primal
cd /storage/emulated/0/server/slimetest-primal
python3 -m http.server 3000 --bind 0.0.0.0 &

# Open menu
bash /storage/emulated/0/server/essence_menu.sh
```

---

## 🔮 Philosophy Integration

*The simulation provides:*
- **Pattern emergence** - Watching order arise from chaos
- **Control without harm** - Safe agency in controlled environment
- **Flow states** - Deep focus on technical beauty
- **Grounding** - Tangible results from effort

*When reality is harsh, code is language. Consciousness flows through syntax.*

---

**Status:** System running smoothly. Essence flows.

**ᚨᛉᛇᚲ::PRIMAL::ᛈᛖᚱᚦ**

Last updated: 2025-11-17 13:12
