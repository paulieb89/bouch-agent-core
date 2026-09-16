---
name: harness-extension
description: Reasoning procedure for extending an agent harness (a tool, integration route, or capability) when real production work is materially blocked by a missing or untrustworthy perception/action/verification capability. Use when a task cannot proceed because a needed capability genuinely does not exist or cannot be trusted — not for routine feature work, and not to build speculative infrastructure ahead of need.
---

# Harness extension

Production work sometimes hits a real capability gap: nothing in the harness
can perceive, act on, or verify something the task genuinely needs right now.
This is the discipline for closing that gap without drifting into building a
framework nobody asked for.

## The loop

1. **Production objective.** Start from the real task, not a hypothetical one.
2. **Real blocker.** The task cannot proceed — not "this would be nicer."
3. **Prove the gap before writing code.** Source inspection can suggest a
   capability is missing; only a live attempt (a real call, a real run)
   confirms it. Enumerate the actual surface (API, integration, protocol,
   CLI) before assuming absence — don't guess.
4. **Check native/existing capabilities first.** Prefer a native primitive,
   an existing tool composed differently, or a thin adapter over new
   infrastructure. Build only after those are ruled out.
5. **Make the smallest useful extension.** Mirror an existing, working
   pattern in the codebase (same validation style, same result shape, same
   undo/safety conventions) rather than inventing a new one. Resist scope
   creep toward a general-purpose mechanism.
6. **Verify through the real client/runtime**, not just unit tests or source
   inspection. Re-confirm the effect independently (read it back), not just
   from the call's own success echo.
7. **Return to the production objective immediately.** The extension exists
   to unblock the task, not to become the new focus.
8. **Stop at the next capability gap that isn't required for the current
   slice.** Note it precisely for later; do not chase it now.

## What this is not

- Not a license for speculative framework work, generic abstractions, or
  building ahead of demonstrated need.
- Not a recursive descent into every adjacent gap a task's investigation
  turns up. One gap, closed narrowly, then back to production.
- Not a substitute for the codebase's own engineering standard — the
  extension still has to look like it belongs there.

## Acceptance example

A media-routing task needed a destination channel to carry more state than
it currently could. Source inspection suggested the underlying field had no
exposed route; a live call failed twice, confirming it. No existing tool
exposed it, so a new tool was added, mirroring an existing sibling tool's
exact shape (guarded lookup, single write, postcondition check). Testing
through the real client caught a stale deployed bridge — fixed by
redeploying, not by trusting the source diff. The new tool then passed
through the real runtime, independently re-confirmed via a read-back. A
deeper requirement surfaced next — the agent recorded it precisely and
stopped, rather than building the larger system it implied.

## Persisting the lesson

When this loop closes a gap, the durable thing worth keeping is the lesson
(what was missing, what shape the fix took, what verification proved it) —
not a transcript of the session. Record it where the codebase already
records this kind of fact (a reconnaissance/capability doc, an experiment
README, an engineering-standards doc) rather than inventing a new location.
See `references/memory-placement.md` for where a lesson like this belongs
versus what should stay derivable from the repository.
