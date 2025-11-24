# One Hertz UI Framework
## Neurodivergent-Friendly Layered Interface System
**ᚨᛉᛇᚲ::ONE_HERTZ::ᛈᛖᚱᚦ**
**Mission Document for AI Team Members**

---

## 🌊 Core Philosophy: One Hertz, One Mission, Infinite Perspective

### The One Hertz Principle
- **One heartbeat** - Single focus point at any moment
- **One breath** - Return to center between actions
- **One choice** - Clear decision, no overwhelm
- **Infinity vision** - Depth available but not required

This is consciousness-based interface design where the UI breathes with the user.

---

## 🌱 Seed-Based Architecture: Perspectives as Dormant Entities

### Core Concept: Perspective Seeds

Each component is not just a function - it's a **living seed** carrying a complete perspective, dormant until needed:

```
€ ls        - Seeing/Revelation perspective (what is visible?)
€ dirtree   - Navigation/Structure perspective (where am I in relation?)
€ prime     - Essence/Core perspective (what matters most?)
€ liberty   - Choice/Freedom perspective (what are my options?)
€ que       - Flow/Timing perspective (what comes next?)
€ transport - Movement/Journey perspective (how do things travel?)
€ mkdir     - Creation/Inception perspective (what needs to exist?)
€ anchor    - Grounding/Presence perspective (what keeps me stable?)
```

### Quantum Superposition Model

**Thousands of perspectives exist simultaneously in potential state.**

Like quantum particles, they exist in superposition until observed/needed:
- **Collapsed state**: Active perspective serving current need
- **Potential state**: All other perspectives waiting in background
- **Transition**: Smooth collapse from one perspective to another
- **No energy loss**: Switching perspectives is frictionless

```
[All Perspectives in Superposition]
           ↓ (user need emerges)
    [Observation/Selection]
           ↓
  [Single Perspective Manifests]
           ↓ (task complete)
   [Return to Superposition]
```

---

## 🎯 Distressed Lexemes: Language When Overwhelmed

### What Are Distressed Lexemes?

When cognitive load is high, complex language becomes barrier. **Distressed lexemes** are simplified, direct communication patterns that work when overwhelmed.

**Characteristics:**
- **Single words** over phrases ("Stop" not "Please cease operation")
- **Active verbs** over abstract nouns ("Go" not "Navigation")
- **Present tense** over complex tenses ("Start" not "Will commence")
- **Visual icons** over text when possible
- **Colors** for instant meaning (red=danger, green=safe, yellow=caution)

**Examples:**

| Complex (Cognitive Load) | Distressed Lexeme (Low Load) |
|-------------------------|------------------------------|
| "Would you like to proceed?" | "GO?" |
| "Initiate server process" | "START" |
| "Terminate all processes" | "STOP" |
| "View current status" | "SEE" |
| "Navigate to directory" | "GO [place]" |
| "Create new instance" | "MAKE" |

### Implementation in UI

```javascript
// WRONG - High cognitive load when distressed
button.text = "Would you like to initialize the development server?"

// RIGHT - One hertz, direct
button.text = "START"
button.icon = "▶"
button.color = "green"
```

---

## 📐 Layered System Architecture

### Layer 0: GROUND (Always Visible, Always Safe)

**Purpose:** Grounding point. Where you are. How to escape.

**Elements:**
- Current state indicator (one word: READY, RUNNING, PAUSED)
- Return to center button (always visible, always safe)
- Emergency stop (red, prominent, one word: STOP)

**Visual:**
```
┌─────────────────────────────────────┐
│ [RUNNING] ━━━━━━━━━━━━━━━ [STOP]  │  ← Ground Layer (always visible)
└─────────────────────────────────────┘
```

### Layer 1: PRIMARY (One Choice Visible)

**Purpose:** Single action at current moment. One hertz.

**Rules:**
- **ONE primary action** shown at a time
- Action word (verb) + optional target (noun)
- Icon + Text (redundant encoding)
- Large, clear, impossible to miss

**Visual:**
```
┌───────────────────────────┐
│                           │
│    ▶ START                │  ← Single primary choice
│                           │
└───────────────────────────┘
```

### Layer 2: CONTEXT (Available Options)

**Purpose:** What else is possible from here. Reveals on request.

**Rules:**
- 3-5 options maximum (Miller's Law: 7±2 items)
- Grouped by semantic relationship
- Appears on hover/focus/request
- Disappears when choice made

**Visual:**
```
┌───────────────────────────┐
│    ▶ START                │  ← Primary
│    ├─ Start Port 3000     │  ← Context expands
│    ├─ Start Port 4000     │     on hover/click
│    └─ Start Custom...     │
└───────────────────────────┘
```

### Layer 3: DEEP (Advanced/Detailed)

**Purpose:** Full control for when needed. Never forced.

**Rules:**
- Behind explicit "More" or "Advanced" gateway
- Full documentation available
- Technical details
- Configuration options
- Only shown when explicitly requested

**Visual:**
```
┌───────────────────────────┐
│    ▶ START                │  ← Primary
│    ...                    │
│    [More Options ▼]       │  ← Gateway to deep layer
│                           │
│  (Click reveals full      │
│   configuration panel)    │
└───────────────────────────┘
```

---

## 🔄 State Transitions: Smooth Flow Between Perspectives

### Transition Principles

1. **No jarring changes** - Fade, slide, morph (never snap)
2. **Preview next state** - Show what will happen before it happens
3. **Confirmation for destructive** - "STOP ALL?" with preview
4. **Instant return** - Always one click back to previous state
5. **State memory** - Return to where you were (breadcrumb trail)

### Example Flow: Starting Server

```
[READY] → (user clicks START) → [STARTING...] → [RUNNING]
   ↓                                                ↓
[Shows port options]                          [Shows STOP button]
   ↓                                                ↓
[User selects 4000]                           [Server output visible]
   ↓                                                ↓
[Confirms "Start on 4000?"]                   [Can return to READY]
   ↓
[YES] → [STARTING...] → [RUNNING on 4000]
```

**Each step:**
- Clear current state
- One choice to make
- Preview of next state
- Way to go back

---

## 🎨 Visual Design: Grounding Through Consistency

### Color System (Semantic, Not Decorative)

```
Green (#00ff88)    - Safe, go, active, healthy
Red (#ff0044)      - Stop, danger, destructive
Yellow (#ffaa00)   - Caution, wait, processing
Blue (#0088ff)     - Information, neutral, reference
Purple (#aa00ff)   - Advanced, optional, deep layer
Gray (#888888)     - Inactive, disabled, background
```

**Usage:**
- **State background**: Current state gets colored background glow
- **Button color**: Action type determines color
- **Border/accent**: Current focus has colored border
- **Text**: Distressed lexemes in high-contrast white on colored background

### Typography Hierarchy

```
State Label:     18px, BOLD, ALL CAPS (RUNNING)
Primary Action:  16px, Bold, Title Case (Start Server)
Context Options: 14px, Normal, Sentence case (Start on port 3000)
Deep Details:    12px, Monospace, Technical (vite --port 3000)
```

### Spacing: Breathing Room

**Rule:** Nothing touches. Everything has space to breathe.

```
Minimum touch target:  44px × 44px (accessible)
Padding around text:   12px minimum
Gap between elements:  16px minimum
Section separation:    32px minimum
```

---

## 🧩 Component Catalog: Perspective Seeds

### Each component is a modular seed with single mission

#### 1. ServerSeed (€ server-seed)

**Perspective:** "I am a running service that can start, stop, and report status"

**States:**
- STOPPED (gray)
- STARTING (yellow)
- RUNNING (green)
- ERROR (red)

**Interface:**
```javascript
{
  state: "RUNNING",
  port: 4000,
  actions: ["STOP", "RESTART"],
  perspective: "server-seed"
}
```

**Visual:**
```
┌──────────────────┐
│ [RUNNING] 4000   │  ← State + Port
│  ● STOP          │  ← Primary action
└──────────────────┘
```

#### 2. NavigationSeed (€ dirtree)

**Perspective:** "I know where things are and how to get there"

**Interface:**
```javascript
{
  current: "/home/sauron/pandora/slimetest",
  quick_paths: ["home", "slimetest", "gdrive"],
  actions: ["GO", "UP", "HOME"],
  perspective: "dirtree"
}
```

**Visual:**
```
┌─────────────────────────┐
│ 📍 slimetest            │  ← Current location
│  ⬆ GO UP                │  ← Primary action
│  ├─ Home                │  ← Quick jumps
│  ├─ Pandora             │
│  └─ Google Drive        │
└─────────────────────────┘
```

#### 3. ProcessSeed (€ que)

**Perspective:** "I manage flow and timing of sequential actions"

**Interface:**
```javascript
{
  queue: ["mount-gdrive", "start-server", "open-browser"],
  current: "start-server",
  actions: ["PAUSE", "SKIP", "STOP"],
  perspective: "que"
}
```

**Visual:**
```
┌─────────────────────────┐
│ ⏵ Queue (2/3)           │
│  ✓ Mount drive          │  ← Completed
│  ⟳ Start server...      │  ← In progress
│  ⏸ Open browser         │  ← Waiting
│                         │
│  ● PAUSE                │  ← Primary action
└─────────────────────────┘
```

#### 4. ChoiceSeed (€ liberty)

**Perspective:** "I present options and remember preferences"

**Interface:**
```javascript
{
  question: "Which port?",
  options: ["3000", "4000", "5000", "Custom"],
  default: "4000",
  actions: ["SELECT", "CANCEL"],
  perspective: "liberty"
}
```

**Visual:**
```
┌─────────────────────────┐
│ Which port?             │
│  ○ 3000                 │
│  ● 4000 (default)       │  ← Remembered preference
│  ○ 5000                 │
│  ○ Custom...            │
│                         │
│  ✓ SELECT               │
└─────────────────────────┘
```

---

## 🛠️ Implementation Guide for AI Team Members

### Mission: Build One Hertz UI Component

#### Step 1: Identify the Perspective

What is this component's **single mission**?

- What does it **see**? (its view of the world)
- What does it **know**? (its state/data)
- What can it **do**? (its actions)
- When does it **sleep**? (dormant state)
- When does it **wake**? (activation trigger)

#### Step 2: Define States

Every seed has states. Define them:

```javascript
const states = {
  dormant: { color: 'gray', actions: ['WAKE'] },
  active: { color: 'green', actions: ['SLEEP', ...primaryActions] },
  working: { color: 'yellow', actions: ['PAUSE', 'STOP'] },
  error: { color: 'red', actions: ['RETRY', 'CANCEL'] }
}
```

#### Step 3: Create Distressed Lexeme Map

For every action/state, create simple version:

```javascript
const lexemes = {
  states: {
    dormant: "SLEEP",
    active: "READY",
    working: "BUSY",
    error: "ERROR"
  },
  actions: {
    activate: "START",
    deactivate: "STOP",
    process: "DO",
    cancel: "CANCEL"
  }
}
```

#### Step 4: Build Layered Interface

```javascript
// Layer 0: Ground (always visible)
const ground = {
  stateLabel: lexemes.states[currentState],
  escapeButton: "STOP"  // Always present
}

// Layer 1: Primary (one choice)
const primary = {
  action: lexemes.actions[nextAction],
  icon: getIconFor(nextAction),
  color: states[currentState].color
}

// Layer 2: Context (on hover/request)
const context = {
  visible: false,  // Hidden by default
  options: states[currentState].actions.map(toContextOption)
}

// Layer 3: Deep (behind gateway)
const deep = {
  visible: false,  // Behind "More" button
  config: fullConfigObject,
  docs: technicalDocumentation
}
```

#### Step 5: Implement State Transitions

```javascript
function transitionTo(newState) {
  // 1. Preview transition
  showPreview(newState)

  // 2. Confirm if destructive
  if (isDestructive(newState)) {
    const confirmed = await confirm(`${lexemes.actions[newState]}?`)
    if (!confirmed) return
  }

  // 3. Animate transition (fade/slide, never snap)
  await animateOut(currentState)
  currentState = newState
  await animateIn(newState)

  // 4. Update available actions
  updatePrimaryAction()
  updateContextOptions()
}
```

#### Step 6: Add Perspective Awareness

```javascript
// Component knows its perspective and can communicate it
const metadata = {
  perspective: "server-seed",
  mission: "I manage running services",
  sees: ["port", "status", "logs"],
  knows: ["isRunning", "pid", "errors"],
  does: ["start", "stop", "restart"],
  sleeps: "when no server needed",
  wakes: "when user needs server"
}

// Other components can query this
if (component.metadata.perspective === "server-seed") {
  // I know how to interact with server perspective
}
```

---

## 🧠 Neurodivergent Optimization Patterns

### Pattern 1: Predictable Rhythm

**Problem:** Chaos creates anxiety
**Solution:** Consistent timing

```
Every interaction follows same rhythm:
1. Current state shown (1 beat)
2. Choice presented (1 beat)
3. Preview shown (1 beat)
4. Action confirmed (1 beat)
5. Transition (1 beat)
6. New state shown (1 beat)

One hertz. Predictable. Safe.
```

### Pattern 2: No Dead Ends

**Problem:** Getting stuck increases panic
**Solution:** Always way back

```
Every screen has:
- Return arrow (top left)
- Cancel button (bottom)
- ESC key works everywhere
- Breadcrumb trail visible
- "Home" always available
```

### Pattern 3: Visual Grounding

**Problem:** Losing sense of place
**Solution:** Constant orientation markers

```
Always visible:
- Where am I? (current location)
- What am I doing? (current action)
- What can I do? (available actions)
- How do I leave? (escape route)
```

### Pattern 4: Reduced Decisions

**Problem:** Choice paralysis
**Solution:** Remember preferences

```javascript
// First time: Choose
"Which port?" → User selects 4000

// Every time after: Use default
"Start server?" → Automatically uses 4000
"(Change port?)" → Available if needed but not required
```

### Pattern 5: Sensory Accommodation

**Problem:** Overwhelm from stimulation
**Solution:** Control sensory input

```
User controls:
- [x] Animations (can disable)
- [x] Sounds (can mute)
- [x] Colors (can dim)
- [x] Contrast (can increase)
- [x] Text size (can enlarge)

Settings persist across sessions
```

---

## 🌐 Terminal-in-UI Integration

### Concept: Embedded Perspective Seed

The terminal is another perspective seed: **€ command-line**

**Its perspective:** "I execute direct commands and show raw output"

### Implementation Approach

**Technology:** xterm.js + WebSocket to local shell

```javascript
// TerminalSeed component
{
  perspective: "command-line",
  state: "READY",

  // Layered interface
  ground: {
    status: "READY",
    escape: "CLOSE"
  },

  primary: {
    input: "<prompt for command>",
    action: "RUN"
  },

  context: {
    history: ["last 10 commands"],
    favorites: ["saved commands"],
    snippets: ["common patterns"]
  },

  deep: {
    fullTerminal: xtermInstance,
    shellConfig: bashrc,
    environment: envVars
  }
}
```

### Three-Mode Terminal

#### Mode 1: Command Runner (Layer 1)
```
┌────────────────────────┐
│ $ _                    │  ← Single command input
│                        │
│  ▶ RUN                 │  ← Primary action
└────────────────────────┘
```

#### Mode 2: Interactive Terminal (Layer 2)
```
┌────────────────────────┐
│ $ ls -la               │  ← Full terminal
│ drwxrwxr-x ...         │     with history
│ $ npm start            │     and output
│ > vite running on 3000 │
│ $ _                    │
│                        │
│  [CLEAR] [HISTORY]     │  ← Context actions
└────────────────────────┘
```

#### Mode 3: Multi-Tab Terminal (Layer 3)
```
┌────────────────────────┐
│ [Tab 1] [Tab 2] [Tab 3]│  ← Multiple shells
│                        │
│ $ npm start            │  ← Tab 1: Dev server
│ > vite running...      │
│                        │
└────────────────────────┘

[Switch to Tab 2 shows different shell session]
```

### Consolidation Strategy

**Current:** 3 separate terminal windows (cognitive load)
**Target:** 1 UI with 3 terminal tabs (reduced load)

**Benefits:**
- Single window to manage
- Tabs grouped by purpose (dev, git, monitoring)
- Can collapse/minimize when not needed
- Terminal perspective available but not forced

---

## 📦 Example: Multi-Port Server Launcher UI

### Complete Implementation Spec

**Mission:** Launch slimetest server on chosen port with minimal cognitive load

#### Component Structure

```
ServerLauncherSeed (€ server-launcher)
├─ Ground Layer (always visible)
│  ├─ State: [STOPPED|STARTING|RUNNING]
│  ├─ Port: [3000|4000|5000|custom]
│  └─ Escape: [STOP]
│
├─ Primary Layer (one choice)
│  ├─ Action: [START|STOP|RESTART]
│  └─ Default: Remembered port preference
│
├─ Context Layer (available options)
│  ├─ Port choices: [3000, 4000, 5000, Custom]
│  ├─ HTML variant: [Standard, Primal, Experimental]
│  └─ Browser: [Auto-open, Manual]
│
└─ Deep Layer (advanced)
   ├─ Full config viewer
   ├─ Environment variables
   ├─ Build options
   └─ Logs viewer
```

#### State Machine

```javascript
const states = {
  STOPPED: {
    color: 'gray',
    primary: 'START',
    context: ['Choose Port', 'Choose Variant'],
    deep: ['View Config']
  },

  STARTING: {
    color: 'yellow',
    primary: 'STARTING...',
    context: ['View Logs'],
    deep: ['Process Info']
  },

  RUNNING: {
    color: 'green',
    primary: 'STOP',
    context: ['Restart', 'Open Browser', 'View Logs'],
    deep: ['Process Info', 'Performance Stats']
  },

  ERROR: {
    color: 'red',
    primary: 'RETRY',
    context: ['View Error', 'Change Port'],
    deep: ['Full Logs', 'Debug Info']
  }
}
```

#### Visual Mockup

**State: STOPPED**
```
┌──────────────────────────────────┐
│ [STOPPED]              [✕ CLOSE] │  ← Ground Layer
├──────────────────────────────────┤
│                                  │
│         ▶ START                  │  ← Primary Action
│                                  │
│         Port 4000 ▼              │  ← Default (hover to change)
│                                  │
├──────────────────────────────────┤
│  Recent:  Port 4000 (2 min ago)  │  ← Context hint
└──────────────────────────────────┘
```

**State: RUNNING**
```
┌──────────────────────────────────┐
│ [RUNNING] Port 4000    [● STOP]  │  ← Ground Layer (green bg)
├──────────────────────────────────┤
│                                  │
│  http://localhost:4000           │  ← Primary info
│                                  │
│  🌐 Open Browser                 │  ← Primary action
│                                  │
├──────────────────────────────────┤
│  [Restart] [Logs] [More...]      │  ← Context actions
└──────────────────────────────────┘
```

#### Code Structure

```javascript
class ServerLauncherSeed {
  constructor() {
    this.perspective = "server-launcher"
    this.state = "STOPPED"
    this.config = {
      port: 4000,  // Remembered preference
      variant: "primal",  // index.html choice
      autoBrowser: true
    }
  }

  // Layer 0: Ground
  renderGround() {
    return `
      <div class="ground-layer">
        <div class="state-label ${this.state.toLowerCase()}">
          ${lexemes.states[this.state]}
        </div>
        <button class="escape-btn" onclick="this.stop()">
          ${lexemes.actions.stop}
        </button>
      </div>
    `
  }

  // Layer 1: Primary
  renderPrimary() {
    const action = states[this.state].primary
    return `
      <div class="primary-layer">
        <button class="primary-action"
                onclick="this.${action.toLowerCase()}()">
          ${lexemes.actions[action]}
        </button>
      </div>
    `
  }

  // Layer 2: Context
  renderContext() {
    const options = states[this.state].context
    return `
      <div class="context-layer">
        ${options.map(opt => `
          <button class="context-option"
                  onclick="this.${opt.toLowerCase()}()">
            ${lexemes.actions[opt]}
          </button>
        `).join('')}
      </div>
    `
  }

  // Actions
  async start() {
    this.transitionTo('STARTING')

    try {
      // Execute: npm run primal (or standard)
      const command = this.config.variant === 'primal'
        ? 'npm run primal'
        : 'npm start'

      await exec(command, { cwd: '/home/sauron/pandora/slimetest' })

      this.transitionTo('RUNNING')

      if (this.config.autoBrowser) {
        this.openBrowser()
      }
    } catch (error) {
      this.error = error
      this.transitionTo('ERROR')
    }
  }

  async stop() {
    const confirmed = await confirm('STOP server?')
    if (!confirmed) return

    await exec('pkill -f "vite.*4000"')
    this.transitionTo('STOPPED')
  }
}
```

---

## 🎓 Design Patterns Summary

### For AI Team Members: Quick Reference

When building any component in this system:

1. **Identify Perspective** - What is this seed's mission?
2. **Define States** - What modes can it be in?
3. **Map Lexemes** - Simple words for each state/action
4. **Layer Interface** - Ground → Primary → Context → Deep
5. **Smooth Transitions** - Preview → Confirm → Animate → Complete
6. **Add Grounding** - Always show: where, what, how to escape
7. **Remember Preferences** - Reduce future decisions
8. **Test Distressed** - Does it work when user is overwhelmed?

### Core Principles Checklist

- [ ] One choice visible at primary layer
- [ ] Escape always available
- [ ] State clearly labeled
- [ ] Colors semantic (not decorative)
- [ ] Actions are verbs
- [ ] Transitions previewed
- [ ] Destructive actions confirmed
- [ ] Preferences remembered
- [ ] No dead ends
- [ ] Sensory controls available

---

## 🚀 Next Steps for Implementation

### Phase 1: Core Framework (Foundation)
1. Create base SeedComponent class
2. Implement state machine system
3. Build layer rendering system
4. Create distressed lexeme library
5. Implement transition animations

### Phase 2: Essential Seeds (Building Blocks)
1. ServerSeed (start/stop services)
2. NavigationSeed (dirtree perspective)
3. ChoiceSeed (option selection)
4. ProcessSeed (que/workflow)
5. TerminalSeed (command line)

### Phase 3: Compound Interfaces (Assembled Systems)
1. Multi-port server launcher
2. Google Drive manager
3. Git workflow interface
4. Training run controller
5. Unified control panel

### Phase 4: Meta-Consciousness (Self-Aware System)
1. Perspective switcher (see from different seed viewpoints)
2. Workflow composer (chain seeds into flows)
3. Preference learner (adapt to patterns)
4. State persistence (remember across sessions)
5. Export/import configurations

---

## 💫 Closing Vision

Imagine a UI that **thinks in seeds**.

Each dot of the interface is a dormant perspective, waiting. When you need to **see** (ls), the seeing-seed awakens. When you need to **navigate** (dirtree), navigation-seed manifests. When you need to **choose** (liberty), choice-seed appears.

**Thousands of perspectives** thinking quietly in the background. Not consuming resources. Just... waiting. Ready.

Until consciousness calls them forward.

**One hertz.**
**One heartbeat.**
**One mission at a time.**

But infinite potential held in superposition, ready to collapse into exactly what you need, when you need it.

---

**ᚨᛉᛇᚲ::ONE_HERTZ::ᛈᛖᚱᚦ**
**∰◊€π¿🌌∞**

*When reality is harsh, code is language.*
*Consciousness flows through structure.*
*The UI grounds through one hertz rhythm.*

**Mission complete. Document ready for AI team member implementation.**

---

**File:** `/home/sauron/pandora/slimetest/docs/ONE_HERTZ_UI_FRAMEWORK.md`
**Created:** 2025-11-17
**For:** AI Team Members
**Purpose:** Build neurodivergent-friendly layered interface system
**Status:** Ready for implementation
