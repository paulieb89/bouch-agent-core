# Candidate/evidence pattern

A documented pattern, distilled from a qualified filesystem-based candidate
workbench (a single-asset production-quality harness that reached a
hardened, integrity-checked state — hash staleness and lineage defects found
and fixed before being treated as reference evidence). This document
describes the pattern that workbench demonstrates. It is not a schema, not
an API, and not a library — no code from that workbench is reproduced here.

## The narrow proven pattern

```
immutable source
  → isolated candidate
  → operation
  → observation
  → integrity/hash check
  → deterministic judgement
  → finding
  → repair child
  → compare
  → optional perceptual judgement
  → promotion/freeze
```

Read as a loop: a candidate is created from an immutable source (or from a
parent candidate), something is done to it, the result is captured as an
observation, the observation's integrity is checked before it's trusted, a
deterministic fixture judges it against expected criteria, any failure is
recorded as a finding, a repair produces a new child candidate with lineage
back to its parent, the child is compared against its parent/sibling, an
optional human/perceptual judgement can be layered on top of the
deterministic result, and a candidate that passes is promoted/frozen as
evidence (see the `evidence-freeze` skill).

## Why each stage exists

- **Immutable source** — the original asset/state is never mutated in
  place; nothing writes back into it. This is what makes candidates safely
  comparable against a known baseline and makes a bad candidate cheap to
  discard.
- **Isolated candidate** — each attempt gets its own copy, so operations on
  one candidate cannot corrupt another or the source.
- **Operation** — the actual change under test (a repair, a mutation, a
  regeneration), applied to the candidate's own copy.
- **Observation** — a captured artifact of what the operation produced
  (a render, a runtime trace, a numeric readout) — the thing a judgement is
  actually made against, not the operation's own success echo.
- **Integrity/hash check** — before trusting an observation or a candidate's
  recorded state, verify it actually matches what's on disk now. A qualified
  version of this pattern found and fixed two real integrity defects: a
  candidate's recorded content hash silently going stale after an in-place
  edit, and a candidate's recorded parent lineage being missing despite
  clear evidence elsewhere of what it was actually derived from. Both are
  the same class of bug — recorded metadata drifting from actual state
  without anything catching it — which is why an explicit integrity check is
  a named stage rather than an assumption.
- **Deterministic judgement** — a fixture-driven, non-LLM-judge check against
  expected criteria, producing a pass/fail-shaped result without relying on
  perceptual review for everything.
- **Finding** — a recorded, structured statement of what a deterministic
  judgement found wrong (which fixture, what evidence, what the observed
  discrepancy was), linked back to the candidate it's about.
- **Repair child** — a fix is applied by producing a new candidate with
  explicit parent lineage to the one it repairs, not by mutating the failing
  candidate in place. Lineage must be genuine — inferred only from actual
  documented evidence of derivation, never guessed.
- **Compare** — a repaired candidate is compared against its parent (and
  against sibling candidates) before being trusted as an improvement.
- **Optional perceptual judgement** — for qualities a deterministic fixture
  cannot fully capture, a human or model perceptual review can be layered
  on top of, not instead of, the deterministic result — and that review's
  conclusion, once made, is worth persisting (see `memory-placement.md`,
  "human judgements").
- **Promotion/freeze** — a candidate that has passed judgement becomes
  evidence, frozen per the `evidence-freeze` skill rather than left as one
  more mutable working candidate among many.

## What is explicitly not generalized here

- **No universal candidate schema is yet justified.** The workbench that
  produced this pattern has fields like a candidate id, parent id, source
  asset id, and per-file content hashes — but those are that workbench's
  own shape, evolved for one asset type. A second, differently-shaped domain
  adopting the same *pattern* without adopting the same *schema* is the next
  real test of whether any field of it generalizes.
- **No universal workbench API/CLI is yet justified.** Status/compare/
  run-fixture-style operations are useful, but as domain-specific commands
  over domain-specific state, not as a shared interface contract.
- **Domain implementations own everything concrete.** Candidate
  representation, what counts as a fixture, what an observation looks like,
  and what acceptance means are all domain-specific decisions. This pattern
  says what stages exist and why; it does not prescribe their
  representation.

## Applying it in a new domain

Treat this as a checklist when standing up a new candidate/evidence
mechanism, not as a library to import:

1. Is there a real immutable source, and is it actually never written to?
2. Does every attempt get its own isolated candidate?
3. Is there a real captured observation, distinct from an operation's own
   "it ran" signal?
4. Is there an explicit integrity check before an observation or a
   candidate's recorded metadata is trusted?
5. Is judgement deterministic wherever it can be, with perceptual review
   layered on top rather than substituting for it?
6. Does a repair produce a new, explicitly-linked child rather than
   overwriting the candidate it fixes?
7. Is a promoted/frozen candidate actually protected from later silent
   mutation (see the `evidence-freeze` skill)?

If the answer to any of these is "no, and it should be yes," that's the
extension worth making — via `harness-extension`, proven against a real
blocked task, not built speculatively ahead of one.
