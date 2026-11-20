# Candidate/evidence pattern

A pattern for workbenches that produce and repair candidates (assets, renders, configurations). It names stages, not a schema: each domain owns its candidate format, fixtures and acceptance criteria.

```
immutable source → isolated candidate → operation → observation
  → integrity check → deterministic judgement → finding
  → repair child → compare → optional human judgement → freeze
```

## Stages

- **Immutable source:** never written to, so every candidate can be compared against a known baseline.
- **Isolated candidate:** each attempt gets its own copy; one candidate can't corrupt another or the source.
- **Operation:** the change under test, applied to the candidate's copy.
- **Observation:** a captured artifact of the result (render, trace, readout) — what judgement is made against, not the operation's success message.
- **Integrity check:** confirm recorded metadata (content hashes, parent lineage) still matches what's on disk before trusting it. Recorded metadata silently drifting from actual state is the defect this catches.
- **Deterministic judgement:** a fixture-driven check against expected criteria, not an LLM judge.
- **Finding:** a structured record of what failed (fixture, evidence, discrepancy), linked to the candidate.
- **Repair child:** a fix creates a new candidate with explicit parent lineage; never mutate the failing one. Record lineage only from real evidence of derivation.
- **Compare:** check the child against its parent and siblings before treating it as an improvement.
- **Human judgement (optional):** layered on top of the deterministic result, never instead of it. Persist the conclusion.
- **Freeze:** a passing candidate becomes evidence, per `evidence-freeze`.

## Checklist for a new domain

1. Is the source genuinely never written to?
2. Does every attempt get its own candidate?
3. Is there a captured observation distinct from "it ran"?
4. Is metadata integrity-checked before it's trusted?
5. Is judgement deterministic where possible, with human review on top?
6. Does a repair create a linked child rather than overwrite?
7. Is a frozen candidate protected from later mutation?

A "no" that should be "yes" is a gap to close via `capability-gap` when real work hits it — not ahead of need.
