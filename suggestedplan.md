You’re exactly right: we’ve been “hand-teaching” behaviors. The next step is to let the bundles **learn** those behaviors from experience.

Here’s a tight, incremental plan that plugs into what you already built—no heavy ML stack required at first—and then scales up if you want.

---

# 0) Make behavior pluggable (controller interface)

Add a controller interface so a bundle can be driven by either:

* the current **heuristic** (what we wrote), or
* a **policy πθ** with learnable parameters.

```js
class Controller {
  // returns {turn, thrust, senseFrac} each in [-1..1] or [0..1]
  act(obs) { return { turn: 0, thrust: 1, senseFrac: 0 }; }
}

class HeuristicController extends Controller {
  constructor(bundle) { super(); this.bundle = bundle; }
  act(obs) {
    // Use your existing computeAIDirection + frustration logic
    // Convert desired heading vs current heading => `turn` in [-1..1]
    // Convert surge desire => `thrust` in [0..1]
    // Convert desired sensing target => `senseFrac` in [0..1]
  }
}

class LinearPolicyController extends Controller {
  constructor(weights) { super(); this.w = weights; } // small matrix + bias
  act(obs) {
    // obs is a vector (see section 1); simple linear head -> tanh/sigmoid
    // y = W*obs + b; turn = tanh(y0), thrust = sigmoid(y1), senseFrac = sigmoid(y2)
  }
}
```

Hook it into `Bundle` with `this.controller` and replace the “decide movement+sense” block with the controller’s outputs.

---

# 1) Define the observation vector (cheap & learnable)

Every frame, build a **normalized obs** vector from what the bundle already “feels”:

* χ state: `[chi_norm, frustration, alive]`
* Motion: `[vx_norm, vy_norm]`
* Walls: `[nx, ny, edge_mag]` from `wallNormal`
* Resource (limited by current sensory range): `[res_dx, res_dy, res_visible]` (0 if not visible)
* Trail samples: 8 or 16 rays → take **mean**, **max**, and **argmax direction** (2D unit) → `[trail_mean, trail_max, tdir_x, tdir_y]`
* Local trail at position: `[trail_here]`
* Time since last collect: `[t_collect_norm]`

A compact example (13 dims):

```
obs = [
  chi/20, frustration, alive?1:0,
  vx/Speed, vy/Speed,
  nx, ny, edge_mag,
  res_dx, res_dy, res_visible,
  trail_mean, trail_max
]
```

(Where `res_dx, res_dy` are unit vector toward resource if visible else 0,0; speeds clipped & normalized.)

---

# 2) Define the action space (continuous, small)

Per step the policy outputs:

* `turn` ∈ [-1..1]  → add to heading (scaled by turn rate)
* `thrust` ∈ [0..1] → multiply base speed (also costs χ as you already do)
* `senseFrac` ∈ [0..1] → fraction of (maxRange-baseRange) to target this frame (your sensing cost function already takes a delta and charges χ)

This maps beautifully onto your existing steering + sensing.

---

# 3) Define the reward (what to “want”)

Keep it simple and on-brand with χ:

* **+R_collect** when touching resource (e.g., +6, same as χ reward)
* **+k_gain · Δχ_pos** (getting χ via residual reuse is good)
* **−k_spend · χ_spent** (metabolic + movement + sensing costs)
* **−k_stuck** when near wall with low speed for too long
* **−k_idle** if not moving and not sensing for N ticks
* Small **+k_explore** for unique trail coverage (encourages mapping)
* Optional: **provenance sharing**: when ledger credits you for others reusing your trail, add a small bonus (teaches “leave useful trails”).

A minimal version:

```
r_t = 1.0·collect_flag
    + 0.2·max(0, Δχ)
    - 0.2·χ_spent
    - 0.1·stuck_flag
```

Episodes can be fixed-length (e.g., 2000 ticks) or “die on χ=0”.

---

# 4) Start with a **no-framework** learner: CEM / CMA-ES

Before PPO/TD3/etc., use **Cross-Entropy Method** (CEM) or **CMA-ES** to learn the **weights of a tiny linear policy** right in the browser:

* Policy: `y = W·obs + b` (e.g., 3×13 weights ≈ 39 + 3 biases)
* Sample N policies from a Gaussian (mean μ, covariance Σ)
* Run each for one episode in parallel (sequentially in JS)
* Keep top K “elites”, update μ, Σ toward elites
* Repeat for a few generations

Why: it’s robust, easy, and doesn’t need gradients or TF.js. You’ll quickly see agents **learn wall-repulsion, trail following, and sensing budgeting** **by themselves**—because it maximizes your reward.

If you want a bit more polish, use **CMA-ES** (JS ports exist), but CEM is fine.

---

# 5) Then graduate to online RL (optional)

If/when you’re ready:

* **Bandit-style** policy gradient (REINFORCE) on your linear head.
* Or **TensorFlow.js PPO** with a tiny 2-layer MLP (e.g., 32→32), still fast in-browser.
* Add **entropy bonus** to keep exploration.
* Add **curriculum**: start with fewer obstacles/diffusion, then increase.

---

# 6) Multi-agent learning & credits (where it gets fun)

You already have a provenance ledger. Use it to fix credit assignment:

* When bundle B earns residual χ on A’s trail, A gets **shaping reward** `+λ · reuse_gain`.
* This makes trail-laying a first-class strategy that the policy discovers.

You can train **independently** (each bundle’s own policy) or **shared policy** with different seeds; both work.

---

