# Root Cause Analysis: Agent Orbiting Behavior

## The Problem
Agents orbit resources at a distance and can't collect them, even with scent gradient and trail following reduced to near-zero.

## Root Causes Identified

### 1. **Weak Resource Attraction Force**
The resource seeking code (line 387-397 in `src/core/bundle.js`) adds only a **magnitude 1.0** unit vector toward the resource:

```javascript
if (resource) {
  const tx = resource.x - this.x;
  const ty = resource.y - this.y;
  const dist = Math.hypot(tx, ty);
  if (dist > 0 && dist <= this.currentSensoryRange) {
    dx += (tx / dist);  // Unit vector = magnitude 1.0
    dy += (ty / dist);
    resourceVisible = true;
  }
}
```

Meanwhile, **other forces are much stronger**:
- **Wall avoidance**: Up to 3.5 magnitude (`aiWallAvoidStrength: 3.5`)
- **Trail following**: Can add significant force (even at 0.5)
- **Exploration noise**: ~0.15-1.26 magnitude
- **Agent collision**: Pushes agents apart
- **Link spring forces**: If enabled

**Result**: Resource attraction (1.0) is easily overpowered by competing forces!

### 2. **Frustration Never Builds When Orbiting**
Line 839 in `src/core/bundle.js`:

```javascript
if (canSeeResource || ticksSinceCollect <= CONFIG.aiFrustrationSightGrace) {
  this.frustration = Math.max(0, this.frustration - CONFIG.aiFrustrationDecayRate * dt);
}
```

**When an agent can SEE a resource, frustration DECAYS.**

So agents orbiting resources (while seeing them) never build frustration, meaning:
- No increased exploration to break out of orbit
- No sensory range expansion
- No speed surge
- They stay calm while circling forever

### 3. **Small Collection Radius**
From your config:
- `resourceRadius: 4` pixels
- `bundleSize: 9` pixels

Agents need to get within ~4-5 pixels to collect. With competing forces, this tight tolerance is hard to achieve.

## The Force Balance Problem

When an agent is near a resource, the force vector is:

```
Total Force = 
  Resource Seeking (1.0)
  + Wall Avoidance (0-3.5)
  + Trail Following (0-0.5+)
  + Exploration Noise (0.15-1.26)
  + Agent Collision (varies)
```

If other forces sum to more than 1.0 in any direction, the resource attraction loses!

## Solutions

### Solution A: Increase Resource Attraction (RECOMMENDED)

Modify `src/core/bundle.js` line 387-397 to add a **distance-based multiplier**:

```javascript
// (2) resource seek within range
if (resource) {
  const tx = resource.x - this.x;
  const ty = resource.y - this.y;
  const dist = Math.hypot(tx, ty);
  if (dist > 0 && dist <= this.currentSensoryRange) {
    // STRONGER PULL when resource is visible
    // Increase from 1.0 to 3.0-5.0 to overpower other forces
    const attractionStrength = 5.0;
    
    // Optional: Increase attraction when closer (1x at max range, 2x when close)
    const distanceFactor = 1.0 + (1.0 - dist / this.currentSensoryRange);
    
    dx += (tx / dist) * attractionStrength * distanceFactor;
    dy += (ty / dist) * attractionStrength * distanceFactor;
    resourceVisible = true;
  }
}
```

This ensures resource attraction (5.0-10.0) overpowers competing forces.

### Solution B: Build Frustration When Not Collecting

Modify frustration logic to detect "stuck orbiting" - can see resource but not collecting:

```javascript
updateFrustration(dt, resource) {
  const tick = currentTick();
  const ticksSinceCollect = tick - this.lastCollectTick;
  const canSeeResource = resource
    ? Math.hypot(resource.x - this.x, resource.y - this.y) <= this.currentSensoryRange
    : false;
  
  // NEW: If we can see resource but haven't collected in a while, build frustration
  const stuckOrbiting = canSeeResource && ticksSinceCollect > 60; // 1 second at 60fps
  
  if (canSeeResource && !stuckOrbiting && ticksSinceCollect <= CONFIG.aiFrustrationSightGrace) {
    this.frustration = Math.max(0, this.frustration - CONFIG.aiFrustrationDecayRate * dt);
  } else if (lowTrail || stuckOrbiting) {
    // Build frustration when stuck orbiting OR in low trail area
    const h = clamp(this.hunger, 0, 1);
    const hungerAmp = 1 + (CONFIG.hungerFrustrationAmp - 1) * h;
    this.frustration = Math.min(1, this.frustration + CONFIG.aiFrustrationBuildRate * hungerAmp * dt);
  }
}
```

### Solution C: Increase Collection Radius

Quick config fix - make resources bigger:

```json
"resourceRadius": 15,  // Was 4
"bundleSize": 9        // Keep same
```

This gives more tolerance for collection but doesn't fix the underlying force balance issue.

### Solution D: Reduce Competing Forces

```json
"aiWallAvoidStrength": 1.5,     // Was 3.5
"aiExploreNoiseBase": 0.05,     // Was 0.15
"aiExploreNoiseGain": 0.2,      // Was 0.55
"agentCollisionPushback": 0.2   // Was 0.5
```

## Recommended Fix

**Implement Solution A** (increase resource attraction strength). This is the cleanest fix that:
1. Makes resource seeking the dominant behavior when a resource is visible
2. Doesn't break other systems
3. Makes biological sense (hunger-driven pursuit should be strongest drive)
4. Can be easily tuned with a new config parameter

## ✅ IMPLEMENTED FIX

**Solution A has been implemented** with the following changes:

### Code Changes

**1. `src/core/bundle.js` (lines 387-407)**
Modified resource seeking to use configurable attraction strength with optional distance scaling:

```javascript
// Use configurable attraction strength to overpower competing forces
const baseAttraction = CONFIG.aiResourceAttractionStrength || 1.0;

// Optional: Scale attraction stronger when closer (1x at max range, up to 2x when very close)
const distanceFactor = CONFIG.aiResourceAttractionScaleWithDistance 
  ? (1.0 + (1.0 - Math.min(dist, this.currentSensoryRange) / this.currentSensoryRange))
  : 1.0;

const attractionStrength = baseAttraction * distanceFactor;

dx += (tx / dist) * attractionStrength;
dy += (ty / dist) * attractionStrength;
```

**2. `config.js` (lines 282-284)**
Added new configuration parameters:

```javascript
// === Resource Seeking ===
aiResourceAttractionStrength: 5.0,          // Strength of pull toward visible resources (1.0 = original, 5.0 = stronger)
aiResourceAttractionScaleWithDistance: true, // Scale attraction stronger when closer to resource
```

**3. `tuning/3.json`**
Updated tuning configuration with new parameters.

### How It Works

- **Base attraction**: 5.0 (5x stronger than original 1.0)
- **Distance scaling**: When enabled, attraction scales from 5.0 at max sensory range to 10.0 when very close
- **Result**: Resource attraction (5.0-10.0) now overpowers competing forces (wall avoidance: 3.5, exploration: ~1.5 max)

## Testing the Fix

After implementing Solution A, you should observe:
1. ✅ Agents beeline toward visible resources (direct pursuit)
2. ✅ Orbiting behavior stops
3. ✅ Collection rate increases dramatically
4. ✅ Agents may still explore when no resource is visible (intended behavior)

### Tuning the Attraction

If agents are still orbiting:
- Increase `aiResourceAttractionStrength` to 7.0 or 10.0

If agents are "too good" (no challenge):
- Reduce to 3.0 or 4.0
- Or disable distance scaling: `aiResourceAttractionScaleWithDistance: false`

If you want original behavior:
- Set `aiResourceAttractionStrength: 1.0`

