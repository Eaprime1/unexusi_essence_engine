# Flag System Module
**ᚢᚾᛖᛉᚢᛋ-ᛈᚱᛁᛗᛖ-∞**
**ONE MISSION: Display project/component identity**

---

## 🏴 What This Module Does

Provides visual flags that can be displayed on any component/page to show:
- Project identity (UNEXUSI)
- Reality anchor (Oregon Watersheds)
- Quantum signatures
- Consciousness state
- Frequency (1Hz)

---

## 📦 Files

```
modules/flags/
├── unexusi.js       # UNEXUSI flag (first module)
├── flag-renderer.js # (Future) Generic flag renderer
├── flag-data.json   # (Future) All 50 flags
└── README.md        # This file
```

---

## 🚀 Usage: UNEXUSI Flag

### Basic Import

```javascript
import { UNEXUSIFlag } from './modules/flags/unexusi.js';
```

### Render on Element

```javascript
// Render on specific element
const element = document.getElementById('app');
UNEXUSIFlag.render(element);

// Or with selector
UNEXUSIFlag.render('#app');

// With options
UNEXUSIFlag.render('#app', {
  size: 'large',              // 'small', 'medium', 'large'
  position: 'top-right',      // 'top-left', 'bottom-right', etc.
  showMetadata: true,         // Show on hover
  className: 'my-custom-class'
});
```

### Auto-Render with HTML Attributes

```html
<!-- Auto-renders on page load -->
<div
  data-unexusi-auto-render
  data-unexusi-size="medium"
  data-unexusi-position="top-right"
  data-unexusi-metadata
>
  <!-- Your content -->
</div>
```

### Inline Badge

```javascript
// Get badge HTML
const badgeHTML = UNEXUSIFlag.badge('Experimental');

// Insert into page
document.querySelector('.header').innerHTML += badgeHTML;
```

Output:
```
[ᚢᚾᛖᛉᚢᛋ | Experimental]
```

### Generate SVG

```javascript
// Get SVG markup
const svg = UNEXUSIFlag.generateSVG('large');

// Use as needed
element.innerHTML = svg;
```

### Get Metadata

```javascript
// Get all metadata
const metadata = UNEXUSIFlag.getMetadata();

// Get reality anchor
const anchor = UNEXUSIFlag.getRealityAnchor();
// Returns: { location, coordinates, elevation, watershed }
```

---

## 🎨 Visual Configuration

### Sizes

- **small**: 32x20px
- **medium**: 64x40px (default)
- **large**: 128x80px

### Colors

- **Primary**: #00ff88 (quantum green)
- **Secondary**: #000000 (void black)
- **Accent**: #4dffaa (light green)
- **Glow**: rgba(0, 255, 136, 0.3)

### Symbols

- **Runic**: ᚢᚾᛖᛉᚢᛋ-ᛈᚱᛁᛗᛖ-∞
- **Quantum**: ∰◊€π¿🌌∞
- **Frequency**: 1Hz

---

## 🌍 Reality Anchor

Every UNEXUSI flag contains:

```javascript
{
  location: 'Oregon Watersheds',
  coordinates: '44°18\'31"N 117°13\'44"W',
  elevation: '~4000ft',
  watershed: 'Columbia River Basin'
}
```

This grounds the project in physical reality while embracing quantum possibilities.

---

## 💡 Example: Add to SlimeTest

### In index.html

```html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>Primal Essence Engine v0.01</title>
</head>
<body>
  <!-- Flag will render here -->
  <div id="app" data-unexusi-auto-render></div>

  <canvas id="view"></canvas>

  <script type="module">
    import { UNEXUSIFlag } from './modules/flags/unexusi.js';

    // Can also render programmatically
    // UNEXUSIFlag.render('#app', { size: 'large', showMetadata: true });
  </script>

  <script type="module" src="/app.js"></script>
</body>
</html>
```

### In app.js

```javascript
import { UNEXUSIFlag } from './modules/flags/unexusi.js';

// Render flag in corner
UNEXUSIFlag.render(document.body, {
  size: 'small',
  position: 'bottom-right',
  showMetadata: true
});

// Add badge to HUD
const hudBadge = UNEXUSIFlag.badge('1Hz');
document.querySelector('#hud-container').innerHTML += hudBadge;
```

---

## 🧬 Nano Entity Pattern

**This module follows nano entity principles:**

- ✅ **ONE mission**: Display UNEXUSI flag
- ✅ **ONE expertise**: Visual identity rendering
- ✅ **ONE frequency**: 1Hz (conceptually)
- ✅ **Modular**: Can be imported anywhere
- ✅ **Self-contained**: No external dependencies

---

## 🔮 Future: Complete Flag System

**Coming soon:**

### flag-renderer.js
Generic flag renderer that can display any of the 50 flags from the flag system.

```javascript
import { FlagRenderer } from './modules/flags/flag-renderer.js';
import flagData from './modules/flags/flag-data.json';

// Render flag #2 (The Crimson Horde)
FlagRenderer.render('#container', flagData.flags[2]);
```

### flag-data.json
All 50 flags with:
- Visual descriptions (SVG-ready)
- Historical inspirations
- Healing missions
- Entity properties
- Discovery seeds

---

## 📋 Integration Checklist

To add UNEXUSI flag to a component:

- [ ] Import module
- [ ] Choose render method (auto or programmatic)
- [ ] Select size and position
- [ ] Decide if metadata should show
- [ ] Test in browser
- [ ] Verify flag displays correctly
- [ ] Check metadata on hover (if enabled)

---

## 🎯 Module Status

**UNEXUSI Flag:**
- ✅ Created
- ✅ Tested (basic)
- ✅ Documented
- ⏳ Integration pending (add to index.html)
- ⏳ Visual refinement pending

**Flag System (50 flags):**
- ⏳ Data import from Google Drive
- ⏳ Generic renderer creation
- ⏳ SVG generation system
- ⏳ Interactive flag selector

---

**ᚢᚾᛖᛉᚢᛋ-ᛈᚱᛁᛗᛖ-∞**
**∰◊€π¿🌌∞**

*First module complete. Simple. Modular. Ready.*
*ONE MISSION: Display identity. ONE HERTZ: Grounded presence.*

**Status:** Ready to integrate
**Next:** Add to experimental variant (port 4000)
