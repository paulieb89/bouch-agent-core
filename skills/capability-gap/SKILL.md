---
name: capability-gap
description: Establishes what an agent can actually do in an unfamiliar or drifted environment, and closes a proven capability gap with the smallest extension. Use when the environment is unfamiliar, a known tool or route stops behaving as documented, or real work is blocked by a missing or untrustworthy capability. Not for routine feature work or every session start.
---

# Capability gap

## Recon: what is actually here

Run when the environment is unfamiliar, a known capability failed in a way that suggests drift (rotated credentials, moved binary, changed API), or a task needs a capability whose shape is unknown. Not at every session start — that is Prime's job (`prime-authoring`).

1. Enumerate from the source itself (`--help`, a manifest, a live listing), not from memory or docs.
2. Classify each capability: **verified** (a real call behaved as expected), **unverified** (present, never exercised) or **absent** (a safe live attempt failed).
3. Before relying on a check's silence, confirm it can fail: run it against a known positive on a fixture or copy, never in production or shared systems. If you can't, label the result uncalibrated.
4. Report counts and shapes, not full listings. Promote only durable conclusions (a routing fact, a confirmed limitation) to the project contract. Don't keep an inventory.

## Extension: closing a proven gap

Only when real work is blocked — not when something would be nicer.

1. Prove the gap with a live attempt; source reading alone misleads. Harmless read-only probes with already-authorised credentials need no permission. If a probe would have side effects, unusual cost or need new credentials, ask or use a harmless equivalent, and label the gap inferred.
2. Prefer, in order: an existing capability as-is → existing capabilities composed → a thin adapter → a new tool.
3. Build the smallest extension, copying an existing working pattern in the codebase (validation style, result shape, safety conventions).
   Use a hook or deterministic gate only for a constraint that is hard to reverse and mechanically checkable (deploy gates, frozen evidence paths, cross-repo writes). Judgement-based rules belong in a Skill.
4. Verify through the real client or runtime and read the effect back; don't trust the call's own success message. If the runtime can't safely be exercised, say what wasn't verified.
5. Return to the original task. Record the next gap precisely; don't chase it.
6. Record the lesson (what was missing, the fix, what proved it) where the codebase keeps such facts, or in `OBSERVATIONS.md` (`observation-log`).

## Example

A routing task needed to write a field no tool exposed. Two live calls confirmed the gap. A new tool copied a sibling tool's shape: guarded lookup, single write, postcondition check. Testing through the real client exposed a stale deployed bridge, fixed by redeploying rather than trusting the source diff. A read-back confirmed the write. A larger requirement surfaced next; the agent recorded it and stopped.
