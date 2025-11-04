Totally makes sense. Let’s anchor “reward” to biology just enough to be principled, then translate it into the sim’s χ economy.

# A. Quick bio anchors (order-of-magnitude)

* **ATP per glucose (eukaryote/slime-mold-like):** ~30–32 ATP per molecule (call it 30).
* **Energy per ATP hydrolysis in cell:** ~50–60 kJ/mol (cellular ΔG), i.e. ~8×10⁻²⁰ J per ATP molecule.
* **So, one glucose → ~30 ATP → ~2.4×10⁻¹⁸ J** captured as usable cellular work (ignoring heat etc.).
* Cells churn a *lot* of ATP. Depending on size & state, rough literature ballpark is **10⁷–10⁹ ATP/s** (order of magnitude; varies widely).

You don’t need exactness—the sim just needs a **consistent ratio** between:

1. baseline “metabolic” spend per second, and
2. energy scored when hitting a food patch.

# B. Two sane mappings to χ (pick one)

## Option 1 — Absolute-ish (molecules → χ)

Choose a conversion like: **1 χ = 10⁸ ATP** (purely convenience so numbers aren’t tiny).

* Basal spend in your sim now is `baseDecayPerSecond = 0.15 χ/s`.
  That equals **0.15 × 10⁸ = 1.5×10⁷ ATP/s** — nicely inside the 10⁷–10⁹ ATP/s range.
* A **food patch size** must be far more than one glucose.
  Example: **1 femtomole glucose = 6×10⁸ molecules**.
  At 30 ATP/glucose → **1.8×10¹⁰ ATP**.
  With 1 χ = 10⁸ ATP → **reward ≈ 180 χ**.

That’s a big reward relative to your current `rewardChi: 6`. But that’s what you want if a patch represents *many molecules*.

> Cheat-sheet:
> `rewardChi ≈ (glucose_molecules_in_patch × 30 ATP/glucose) / (10^8 ATP per χ)`

If you want smaller patches, pick attomoles (10⁻¹⁸ mol) → 6×10⁵ molecules → ~1.8×10⁷ ATP → **0.18 χ** (tiny).

## Option 2 — Relative (behavioral) — often better for RL

Set reward so a typical successful find **pays back** the expected cost of searching for it, with a margin.

* Let `C_base = baseDecayPerSecond + f_move * moveCostPerSecond`, where `f_move` is average fraction of time moving (e.g., 0.6–0.8).
* Let **T_find** be the moving average of time between finds (seconds).
* Set **rewardChi = gainFactor × C_base × T_find**.
  Where `gainFactor` is your “ecosystem generosity” (2–10×).

This keeps reward automatically in the right regime as you tweak dynamics.

# C. Practical recommendation (numbers you can drop in)

Start with **relative reward**, but keep the bio mapping in the comments so it’s principled.

1. Track moving average of time-to-resource:

```js
// in World:
avgFindTime: 8,               // start with a guess (s)
avgAlpha: 0.1,                // EMA smoothing
lastFindTime: performance.now()/1000,
```

2. When a resource is collected (right where you already add χ):

```js
const nowSec = performance.now()/1000;
const dtFind = Math.max(0.05, nowSec - World.lastFindTime);
World.lastFindTime = nowSec;
World.avgFindTime = (1 - World.avgAlpha) * World.avgFindTime + World.avgAlpha * dtFind;

// compute behavior-aware reward
const f_move = 0.7; // assume ~70% moving; adjust if you track actual
const C_base = CONFIG.baseDecayPerSecond + f_move * CONFIG.moveCostPerSecond;
const gainFactor = 6; // 4..10 is a good starting range
const rewardChi = gainFactor * C_base * World.avgFindTime;

// pay reward
bundle.chi += rewardChi;
```

With your current defaults:

* `C_base ≈ 0.15 + 0.7*0.35 = 0.395 χ/s`
* If `avgFindTime ≈ 8 s`, and `gainFactor = 6`,
  `reward ≈ 6 * 0.395 * 8 ≈ 19 χ`.

That’s already **3–5×** your old reward of 6 χ—enough to *feel* like food matters.

3. If you want to keep an “absolute bio” knob too, add an optional override:

```js
// Optional absolute anchor (disabled unless you flip the flag)
const useAbsolute = false;
if (useAbsolute) {
  const chiPerATP = 1 / 1e8; // 1 χ per 1e8 ATP
  const molecules = 6e8;     // 1 femtomole
  const atp = molecules * 30;
  const absoluteChi = atp * chiPerATP; // ~180 χ
  bundle.chi += absoluteChi;
} else {
  bundle.chi += rewardChi;
}
```

# D. Tiny RL consequences

* A bigger, *search-time-scaled* reward makes “seek resource” **learnable sooner**, because returns dominate noisy residual gains and wall penalties.
* You can still reward **public goods**: e.g., add `+λ * reuse_gain` to the reward when others harvest your trails (`λ ~ 0.25–0.5`) so they learn “leave good paths.”
* If the agent starts gaming “stand still, save χ,” increase `f_move` based on actual movement fraction or add a small **idle penalty**.

# E. Suggested CONFIG tweaks to pair with this

```js
// make food a bigger deal & stabilize trails
evapPerSec: 0.22,          // slightly faster fade so maps need refreshing
residualGainPerSec: 0.35,  // keep reuse helpful but not dominant
residualCapPerTick: 0.25,
aiTrailFollowingFar: 3.0,  // still strong when blind
```

---

If you want, I can splice the **EMA reward** code into your `v0.4` loop (just a handful of lines) so rewards now scale with the actual difficulty of finding food.
