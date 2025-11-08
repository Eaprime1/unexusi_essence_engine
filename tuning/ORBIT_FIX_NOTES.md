# Orbit Behavior Fix - Complete Analysis

## Problem
Agents were orbiting resources at a significant distance instead of approaching them directly, even with:
- Scent gradient system disabled
- Trail following reduced to near-zero
- Small resource and bundle sizes

## Initial Investigation: Trail Following
The first suspected issue was **trail following** creating self-reinforcing circular patterns:

1. **Trail Following Active**: Agents followed trails with 25% strength when resources visible
2. **Self-Reinforcing Circles**: Circular trails reinforced orbital behavior
3. **Solution Applied**: Reduced trail following (0.0 near, 0.5 far)

**Result**: ❌ Orbiting persisted even with trails at minimum

## Root Cause Discovery
Further investigation revealed the **real problem**: **Weak Resource Attraction Force**

### The Force Balance Problem
Resource seeking only added a magnitude **1.0** force, while competing forces were much stronger:

- **Resource Attraction**: 1.0 (too weak!)
- **Wall Avoidance**: Up to 3.5
- **Exploration Noise**: 0.15-1.26
- **Trail Following**: 0.5+
- **Agent Collision**: Variable pushback

**Result**: Resource attraction was easily overpowered by other forces!

### Secondary Issue: Frustration Never Built
When agents could see a resource (even while orbiting), frustration **decayed** instead of building:

```javascript
if (canSeeResource) {
  this.frustration -= decayRate; // Never builds while orbiting!
}
```

This prevented the desperate seeking behavior needed to break out of orbits.

## ✅ Complete Solution Implemented

### Code Changes

**1. Increased Resource Attraction Strength** (`src/core/bundle.js`)
- Base attraction: 1.0 → **5.0**
- Added distance scaling: Attraction increases from 5.0 to 10.0 as agent gets closer
- Now overpowers all competing forces

**2. New Configuration Parameters** (`config.js`)
```javascript
aiResourceAttractionStrength: 5.0           // Base attraction multiplier
aiResourceAttractionScaleWithDistance: true // Scale stronger when closer
```

**3. Updated Tuning Config** (`tuning/3.json`)
- Trail following: Near=0.0, Far=0.5
- Resource attraction: 5.0 with distance scaling

## Additional Tuning Options

If agents still exhibit orbiting behavior, try these:

### Option 1: Increase Direct Pursuit Range
The code has a proximity factor that reduces trail following when close to resources. You could increase this range, but it requires a code change in `src/core/bundle.js` around line 406:

```javascript
const closeRange = (resource.r || 15) + this.size / 2 + 30;  // Current
const closeRange = (resource.r || 15) + this.size / 2 + 100; // Larger range
```

### Option 2: Reduce Sample Distance
Lower `aiSampleDistance` so agents don't look as far ahead for trails:
- Current: 46
- Try: 30 or 20

### Option 3: Disable Trail Rendering (if trails are confusing)
Set `renderTrail: false` to hide the visual trails (they'll still deposit, but won't be visible)

### Option 4: Reduce Trail Deposition
- `depositPerSec`: 2.5 → 1.0 (agents leave weaker trails)
- This reduces the strength of circular trail patterns

## Testing
1. Load the updated `tuning/3.json` configuration
2. Observe agent behavior around resources
3. Agents should now approach resources more directly
4. Some exploration/wandering is still expected due to `aiExploreNoiseBase` (0.15) and frustration system

## Code References

The trail following logic is in `src/core/bundle.js` in the `computeAIDirection()` method:
- Lines 399-441: Trail following computation
- Lines 404-412: Proximity reduction
- Line 422: Sample distance usage
- Lines 424-440: Trail sampling in multiple directions

