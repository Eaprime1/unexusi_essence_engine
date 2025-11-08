# Resource Hover Tooltip Feature

## Overview

You can now hover your mouse over any resource to see real-time information about its state, including scent gradient values!

## How to Use

1. **Hover Near Resources**: Move your mouse cursor within ~30 pixels of any resource (green circle)
2. **View Tooltip**: A dark tooltip will appear showing detailed resource information
3. **Watch Values Update**: Keep hovering to see values change in real-time during agent interactions

## Tooltip Information

### Basic Info
- **Resource #**: Which resource it is (numbered 1, 2, 3, etc.)
- **Position**: Exact (x, y) coordinates on canvas
- **Radius**: Resource collection radius in pixels
- **Age**: How many ticks since this resource spawned
- **Visible**: Whether the resource is visible/collectible

### Scent Gradient Values (Below the separator line)
- **Scent Strength**: Current gradient strength (changes when consumed!)
  - **Color-coded**: Green = full strength, Yellow = medium, Red = depleted
  - Starts at base value (default: 1.0)
  - Decreases when agents orbit (if consumable is enabled)
  - Recovers when no agents are nearby
  
- **Scent Range**: Current detection range in pixels
  - Scales proportionally with strength
  - Shrinks when strength depletes
  
- **Base Strength**: The configured starting/maximum strength
- **Min Strength**: The floor value (won't deplete below this)
- **Consumable**: Whether gradient consumption is enabled

### Visual Indicators

- **Border Color**: 
  - Green (#00ff88) when consumable is enabled
  - Gray (#888) when consumable is disabled
  
- **Connector Line**: Dotted line from resource to tooltip
  
- **Smart Positioning**: Tooltip automatically moves to stay on screen

## Testing Gradient Consumption

Now you can verify if consumption is working:

### Step 1: Enable Scent Gradient
```json
"scentGradient.enabled": true,
"scentGradient.consumable": true,
"scentGradient.maxRange": 300
```

### Step 2: Watch for Depletion
1. Hover over a resource to see initial values (e.g., Strength: 1.000)
2. Watch agents approach and orbit the resource
3. Keep tooltip open - you should see:
   - **Scent Strength** decreasing (1.000 → 0.900 → 0.800...)
   - **Scent Range** shrinking proportionally
   - **Color changing** from green → yellow → orange → red

### Step 3: Watch Recovery
1. When agents move away or collect the resource
2. Values should slowly recover:
   - **Scent Strength** increasing back toward base
   - **Scent Range** expanding back to max
   - **Color shifting** back to green

## Configuration Reference

These settings affect what you'll see in the tooltip:

```json
"scentGradient.enabled": true,         // Must be true to see effects
"scentGradient.consumable": true,      // Enable depletion
"scentGradient.consumePerSec": 0.15,   // How fast strength depletes
"scentGradient.recoverPerSec": 0.03,   // How fast it recovers
"scentGradient.minStrength": 0.2,      // Depletion floor
"scentGradient.minRange": 150,         // Range floor (px)
"scentGradient.strength": 1.0,         // Base/max strength
"scentGradient.maxRange": 400,         // Base/max range (px)
"scentGradient.orbitBandPx": 140       // Consumption zone size
```

## Troubleshooting

### Tooltip Doesn't Appear
- Make sure you're hovering within ~30 pixels of a resource
- Move cursor around the green circle
- Try hovering over different resources

### Values Never Change
- Check `scentGradient.enabled: true`
- Check `scentGradient.consumable: true`
- Verify agents are orbiting (distance 4-144px from resource)
- With strong resource attraction (5.0), agents rarely orbit - try reducing to 1.0 temporarily

### Can't Read Tooltip
- Tooltip auto-positions to stay on screen
- If resource is near edge, tooltip will flip to other side
- Background is semi-transparent dark gray with colored border

## Tips

- **Pause the simulation** (Space bar) to read tooltip without it moving
- **Lower resource attraction** temporarily (`aiResourceAttractionStrength: 1.0`) to see more orbiting
- **Increase consumption rate** (`consumePerSec: 0.5`) to see changes faster
- **Watch multiple resources** - hover between them to compare depletion states
- **Use with debug mode** - Enable `debug: true` for additional console logging

## Feature Details

- **Update Rate**: Real-time (60fps with simulation)
- **Hover Radius**: 30 pixels (resource radius + 26px for small resources)
- **Precision**: Strength shown to 3 decimal places
- **Performance**: Minimal impact - only draws when hovering

The tooltip updates every frame while hovering, so you can watch consumption happen in real-time!

