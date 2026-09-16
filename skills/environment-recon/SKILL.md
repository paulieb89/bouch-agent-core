---
name: environment-recon
description: Bounded procedure for discovering and calibrating an agent's real capability surface (tools, APIs, integrations, credentials) when the environment is unfamiliar or has drifted since it was last checked. Use once at the start of unfamiliar work, or when a known surface stops behaving as documented — not on every session start, and not as a substitute for /prime deriving current work state.
---

# Environment recon

Recon answers "what can this agent actually do here, and how much should I
trust each answer" — once, when that is genuinely unknown or has drifted.
It is not a status report and not something to run out of habit.

## When to run this

- The environment (project, machine, integration set) is genuinely unfamiliar.
- A previously-known capability just failed in a way that suggests drift
  (credentials rotated, a binary moved, an API version changed, a route was
  removed).
- A production task needs a capability whose existence or shape is unknown,
  and a full harness-extension pass would be premature before checking what
  already exists.

Do not run recon reflexively at the start of every session — that is Prime's
job at a much smaller scope (see `references/prime-contract.md` and the
`prime-authoring` skill). If Prime's pulse-check fails or a cited fact turns
out stale, that is the signal to hand off to recon, not to expand Prime.

## The procedure

1. **Enumerate before assuming.** List what actually exists — installed
   binaries, registered integrations/MCP servers, exposed tool/route sets,
   credentials/permissions in force — from the authoritative source itself
   (`--help`, a manifest, a live listing), not from memory or documentation
   alone.
2. **Separate availability from credibility.** A capability being present is
   not the same as it being trustworthy. Distinguish:
   - *available and verified* — a real call/run has confirmed it behaves as
     expected;
   - *available but unverified* — present, but never actually exercised;
   - *not available* — genuinely absent, confirmed by a live attempt, not
     just an unread doc.
   Record this distinction positively (what was checked and what it showed),
   not as a hand-maintained inventory that will silently go stale.
3. **Reuse before composing, compose before building.** Prefer an existing
   capability used as-is; then an existing capability composed differently;
   only then consider extension (hand off to `harness-extension` — recon
   identifies the gap, it does not close it).
4. **Identify genuine gaps precisely.** A gap is genuine only after a live
   attempt fails, not after source inspection alone suggests absence. State
   the gap narrowly — what specific action is blocked — rather than as a
   general capability wishlist.
5. **Stop at a bounded result.** Recon produces a compact answer to the
   question that motivated it: what's here, what's credible, what's missing
   for the task at hand. It does not become a permanent, ever-growing
   capability catalog, and it does not dump raw tool listings or full API
   surfaces into working context — cite counts/shapes, not full enumerations.

## What this is not

- Not Prime. Prime derives bounded current-work state and cites already-known
  routing facts; recon is what establishes those facts in the first place,
  or re-establishes them after drift.
- Not a periodic capability audit. Run it when a real question demands it.
- Not a place to persist findings verbatim. If a recon finding is genuinely
  durable and load-bearing (a routing fact, a confirmed limitation), promote
  the distilled conclusion into the project's durable contract or a
  reference doc — see `references/derive-vs-persist.md`. The raw recon
  session itself does not need to survive.
