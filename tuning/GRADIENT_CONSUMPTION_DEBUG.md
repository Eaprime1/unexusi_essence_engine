# Scent Gradient Consumption Feature - Debug Analysis

## How It Works

The consumable gradient feature is in `app.js` lines 1553-1584. Here's the logic:

### Consumption Zone
```javascript
const inner = res.r;                    // Resource radius (currently 4px)
const outer = res.r + orbitBandPx;      // Resource radius + orbit band (4 + 140 = 144px)

if (nearest > inner && nearest <= outer) {
  // Agent is "orbiting" - consume gradient
  const t = 1 - (nearest - inner) / (outer - inner);  // 0 at outer, 1 at inner
  const use = t * t;                                   // Quadratic falloff
  res.scentStrength -= consumeRate * use;
  res.scentRange = targetRange (based on strength fraction);
} else {
  // No agent orbiting - recover gradient
  res.scentStrength += recoverRate;
  res.scentRange += recovery;
}
```

### Current Configuration
From `tuning/3.json`:
- `scentGradient.enabled`: **false** ⚠️
- `scentGradient.consumable`: **true**
- `scentGradient.consumePerSec`: 0.15
- `scentGradient.recoverPerSec`: 0.03
- `scentGradient.minStrength`: 0.2
- `scentGradient.minRange`: 150
- `scentGradient.orbitBandPx`: 140
- `resourceRadius`: 4 pixels

## Potential Issues

### 1. ⚠️ GRADIENT SYSTEM IS DISABLED
The scent gradient system is turned off (`enabled: false`), so consumption has no effect since:
- No gradient is being generated
- Agents aren't following gradients
- The consumption code runs but the values don't affect anything

**Fix**: Set `scentGradient.enabled: true` if you want consumption to have an effect.

### 2. Agents No Longer Orbit (Due to Recent Fix)
With the new resource attraction fix (`aiResourceAttractionStrength: 5.0`), agents beeline straight to resources instead of orbiting. This means:
- Agents spend very little time in the orbit band (4-144px)
- Consumption happens for only a brief moment before collection
- Gradient barely depletes before recovering

**This might actually be CORRECT behavior** - if agents aren't orbiting, gradients shouldn't deplete!

### 3. Very Small Resource Radius
With `resourceRadius: 4` pixels:
- `inner` = 4px
- `outer` = 144px
- Consumption zone is 4-144px

This is a huge band (140px wide), so agents should trigger consumption easily.

### 4. Orbit Band Check Logic
The condition `nearest > inner && nearest <= outer` means:
- Agents INSIDE the resource (distance ≤ 4) do NOT consume gradient
- Agents in the 4-144px zone DO consume gradient
- Agents far away (> 144px) do NOT consume gradient

This seems correct - you don't want agents standing on top of the resource to consume its gradient.

## Testing the Feature

### Step 1: Enable Gradients
```json
"scentGradient.enabled": true
```

### Step 2: Check Current Values
Add debug logging to see if consumption is happening:

```javascript
// In app.js around line 1572
if (nearest > inner && nearest <= outer) {
  console.log(`Consuming: nearest=${nearest.toFixed(1)}, strength=${res.scentStrength.toFixed(2)}, range=${res.scentRange.toFixed(0)}`);
  // ... existing code
} else {
  console.log(`Recovering: nearest=${nearest.toFixed(1)}, strength=${res.scentStrength.toFixed(2)}`);
}
```

### Step 3: Test Orbiting Behavior
To see if consumption works when agents orbit:
1. Temporarily reduce resource attraction: `aiResourceAttractionStrength: 1.0`
2. This will make agents orbit again
3. Watch if gradients deplete

### Step 4: Increase Consumption Rate
If consumption is too slow to notice:
```json
"scentGradient.consumePerSec": 0.5,   // Was 0.15 (3x faster)
"scentGradient.recoverPerSec": 0.01   // Was 0.03 (slower recovery)
```

## Expected Behavior

**When Working Correctly:**
1. Agent approaches resource from far away
2. When agent enters orbit band (4-144px), `scentStrength` starts decreasing
3. When agent collects resource or moves away, `scentStrength` recovers
4. Gradient range (`scentRange`) shrinks proportionally to strength
5. Visual indicator (if enabled) shows weaker/smaller gradient

**Signs It's NOT Working:**
1. `scentStrength` always stays at base value (1.0 or configured strength)
2. No console errors
3. Resources have undefined `scentStrength` or `scentRange` properties

## Diagnostic Commands

Run in browser console:
```javascript
// Check if resources have scent properties
World.resources.forEach((res, i) => {
  console.log(`Resource ${i}: strength=${res.scentStrength}, range=${res.scentRange}`);
});

// Check if gradient system is enabled
console.log('Gradient enabled:', CONFIG.scentGradient.enabled);
console.log('Consumable:', CONFIG.scentGradient.consumable);

// Check nearest agent distance to a resource
const res = World.resources[0];
const bundle = World.bundles[0];
const dist = Math.hypot(res.x - bundle.x, res.y - bundle.y);
console.log(`Distance to resource: ${dist.toFixed(1)}px`);
console.log(`Orbit zone: ${res.r} to ${res.r + CONFIG.scentGradient.orbitBandPx}`);
```

## Most Likely Issue

Since `scentGradient.enabled: false` in your config, the consumption feature is running but has no visible effect because:
- Gradients aren't being rendered
- Agents aren't sensing gradients
- The weakened gradient doesn't matter

**Solution**: Enable the gradient system to see consumption in action:
```json
"scentGradient.enabled": true,
"scentGradient.showSubtleIndicator": true
```

Then watch the pulsating rings around resources - they should shrink when agents orbit!

