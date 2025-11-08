# Resource Vitality System

## Overview

The resource vitality system adds **resource depletion** mechanics where resources can be "overharvested" and become temporarily uncollectible when agents orbit them too aggressively.

## How It Works

### Vitality Depletion
When agents orbit a resource (distance 4-144px by default), the resource's **vitality** (health) decreases:
- Starts at 1.0 (100% healthy)
- Depletes at `vitalityConsumePerSec` rate when agents orbit
- Recovers at `vitalityRecoverPerSec` rate when no agents orbit
- Has a floor at `minVitality` (default: 0.0)

### Depletion Threshold
When vitality drops below `depletionThreshold` (default: 0.3):
- Resource becomes **DEPLETED**
- Resource is **uncollectible** - agents pass through it
- Resource appears brown/gray instead of green
- Tooltip border turns RED
- Status shows "DEPLETED" in red

### Recovery
When agents move away or stop orbiting:
- Vitality slowly recovers (default: 0.02/sec)
- When vitality rises above `depletionThreshold + 0.1` (0.4):
  - Resource becomes collectible again
  - Color returns to green
  - Status shows "Available"

## Configuration

```json
"scentGradient": {
  "consumable": true,
  "vitalityConsumePerSec": 0.10,      // How fast vitality depletes (0.1 = 10%/sec)
  "vitalityRecoverPerSec": 0.02,      // How fast vitality recovers (0.02 = 2%/sec)
  "minVitality": 0.0,                 // Floor (0 = can fully deplete)
  "depletionThreshold": 0.3           // Below 30% = uncollectible
}
```

### Depletion Speed Examples

**With default settings (vitalityConsumePerSec: 0.10):**
- Takes ~7 seconds of orbiting to deplete from 1.0 → 0.3
- Takes ~35 seconds to fully deplete to 0.0
- Takes ~35 seconds to recover from 0.3 → 1.0

**Fast depletion (vitalityConsumePerSec: 0.25):**
- Takes ~3 seconds to become uncollectible
- Takes ~14 seconds to fully deplete
- Creates more resource scarcity

**Slow depletion (vitalityConsumePerSec: 0.05):**
- Takes ~14 seconds to become uncollectible
- Takes ~70 seconds to fully deplete
- More forgiving for agents

## Visual Indicators

### Resource Color
- **Bright Green** (vitality 0.6-1.0): Healthy, fully collectible
- **Yellow-Green** (vitality 0.3-0.6): Weakening but still collectible
- **Brown/Gray** (vitality 0.0-0.3): Depleted, uncollectible

### Tooltip
Hover over resource to see:
- **Vitality**: Current health (color-coded)
  - Green = healthy (> 0.6)
  - Yellow/Orange = weakened (0.3-0.6)
  - Red = depleted (< 0.3)
- **Status**: "Available" (green) or "DEPLETED" (red)
- **Tooltip border**: Red when depleted, green when available

### Glow Effect
Resource glow intensity decreases with vitality:
- Full glow at 100% vitality
- Dim glow at 50% vitality
- Almost no glow when depleted

## Ecological Effects

### Resource Competition
Multiple agents orbiting the same resource will deplete it faster, creating:
- **Resource rotation**: Agents must move between resources
- **Spatial distribution**: Agents spread out to find available resources
- **Recovery time**: Resources need "rest" periods

### Emergent Behaviors
- **Grazing**: Agents that collect quickly deplete resources less
- **Overharvesting**: Agents that orbit excessively deplete resources
- **Migration**: Agents must leave depleted areas and return later
- **Resource management**: System naturally limits resource extraction rate

## Tuning for Different Scenarios

### Abundant Resources (Easy Mode)
```json
"vitalityConsumePerSec": 0.05,       // Slow depletion
"vitalityRecoverPerSec": 0.05,       // Fast recovery
"depletionThreshold": 0.1            // Only depletes at very low vitality
```

### Scarce Resources (Hard Mode)
```json
"vitalityConsumePerSec": 0.20,       // Fast depletion
"vitalityRecoverPerSec": 0.01,       // Slow recovery
"depletionThreshold": 0.5            // Depletes early
```

### Balanced (Default)
```json
"vitalityConsumePerSec": 0.10,       // Medium depletion
"vitalityRecoverPerSec": 0.02,       // Medium recovery
"depletionThreshold": 0.3            // Depletes at 30%
```

### Disabled
```json
"consumable": false                   // Turns off entire system
```

## Interaction with Scent Gradient

Both systems work together:
1. **Scent Strength** depletes → Harder to detect from far away
2. **Vitality** depletes → Resource becomes uncollectible when too low
3. Both recover when agents leave

This creates a layered depletion:
- First: Detection range shrinks (scent)
- Then: Resource becomes uncollectible (vitality)
- Recovery: Both systems recover in parallel

## Testing

### Watch Depletion
1. Enable consumable: `"consumable": true`
2. Hover over a resource
3. Watch agents orbit it
4. **Vitality** line turns yellow → orange → red
5. **Status** changes to "DEPLETED" when < 0.3
6. Agents pass through without collecting

### Watch Recovery
1. Wait for agents to leave
2. Keep tooltip open
3. **Vitality** slowly increases
4. Color shifts back: red → orange → yellow → green
5. **Status** changes back to "Available" when > 0.4
6. Agents can collect again

## Debug Commands

```javascript
// Check resource vitality
World.resources.forEach((res, i) => {
  console.log(`Resource ${i}: vitality=${res.vitality.toFixed(2)}, depleted=${res.depleted}`);
});

// Manually deplete a resource
World.resources[0].vitality = 0.2;
World.resources[0].depleted = true;

// Manually restore a resource
World.resources[0].vitality = 1.0;
World.resources[0].depleted = false;
```

## Key Differences from Old System

**Before (gradient only):**
- Scent gradient depleted
- Resource stayed fully collectible
- No visible depletion on resource itself

**Now (vitality + gradient):**
- Scent gradient AND vitality deplete
- Resource becomes uncollectible when vitality too low
- Visual feedback: color changes, tooltip shows status
- Agents must wait for recovery before collecting

The whole resource node now gets consumed, not just the scent!

