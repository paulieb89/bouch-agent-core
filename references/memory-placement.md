# Memory placement

Cross-session memory is one layer among several that could plausibly hold a
given fact. Putting a fact in the wrong layer either makes it go stale
silently (if it duplicates something derivable) or makes it unfindable when
needed (if it's genuinely durable but left implicit). This document is the
boundary between the layers.

## The layers

1. **Repository/runtime** — anything an authoritative source can answer
   directly, right now: git state, the current file tree, installed
   packages, live capability state, current candidate/experiment status,
   test results. Authoritative and always current by construction. See
   `derive-vs-persist.md`.
2. **Durable contract** — small, load-bearing project instructions/config
   that must be present routinely (`CLAUDE.md`/`AGENTS.md`, permissions,
   integration registration, invariants). Changes rarely; checked into the
   project.
3. **Prime** — not a storage layer at all, but the place that *cites* a
   small number of already-established facts from layers 2 and 4, plus a
   cheap pulse-check against layer 1. See `prime-contract.md`.
4. **Memory** — cross-session, cross-project semantic knowledge that
   layers 1–3 cannot hold because it isn't project-local, isn't cheaply
   re-derivable, or is about the working relationship rather than the
   codebase. Covered in detail below.
5. **History/forensics** — raw session transcripts and logs, kept outside
   working context and queried on demand by an observability tool when a
   specific question needs them, rather than distilled proactively. See
   `cross-domain-harness-model.md` §7.

## What belongs in memory

- **Semantic decisions** — a considered choice with a rationale, where the
  rationale is the valuable part (why this approach over the obvious
  alternative), not just the choice itself.
- **Expensive-to-relearn lessons** — something that took a real
  investigation, a failure, or an incident to discover, where re-deriving it
  from scratch would be wasteful.
- **Human judgements** — a person's (or a perceptual review's) conclusion
  that a mechanical check cannot reproduce, and that would otherwise be lost
  once the session ends.
- **Do-not-reopen conclusions** — a settled question, recorded so it isn't
  silently re-litigated later with a different, uncoordinated answer.
- **Pointers to authoritative evidence** — a memory record naming *where*
  frozen evidence, a qualified baseline, or a detailed doc lives, rather
  than duplicating its content.

## What must not go in memory

- **Current git state** — branch, dirty/clean, commit history: always
  derive from the repository.
- **Executable paths** — where a binary or interpreter lives on this
  machine: this is exactly the kind of routing fact that belongs in a
  project's durable contract or a recon finding, checked when actually
  needed, not carried as a memory fact that can silently go stale the
  moment the machine changes.
- **Live capability state** — whether an integration is currently up,
  whether a tool currently works: pulse-check it, don't remember it.
- **Candidate status** — a workbench candidate's current state belongs in
  that workbench's own state files, which are authoritative for it.
- **Measurements already stored in experiment evidence** — if a frozen
  evidence record already holds a measurement, memory should point at that
  record, not re-state the number (numbers copied into memory drift from
  the source and cannot be re-verified against it).
- **Tool inventories** — a list of what tools/capabilities exist: this is
  recon's or the runtime's job to answer on demand, not a standing memory
  list to keep in sync.

## The test to apply

Before writing something to memory, ask: *would repository/runtime evidence
outrank this if the two ever disagreed?* If yes, it doesn't belong in
memory — memory should record what evidence cannot cheaply re-derive, and
should defer to fresher evidence whenever they conflict rather than being
treated as equally authoritative.
