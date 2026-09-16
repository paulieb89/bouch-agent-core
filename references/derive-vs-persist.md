# Derive vs. persist

A recurring failure mode across agent harnesses is hand-maintaining a copy
of something an authoritative source could answer directly, and a second,
opposite failure mode of failing to keep anything that a source genuinely
cannot reconstruct. This document is the rule that avoids both.

## The rule

If an authoritative source can cheaply answer a question *now*, derive it.
Do not hand-maintain a copy of something the runtime, repository, or a live
introspection call can report.

Examples of things to derive, not persist:
- current git state (branch, dirty/clean, ahead/behind, recent commits);
- current tool/capability count or inventory (ask the runtime, don't keep a
  hand-written list);
- test inventory and current pass/fail state;
- deployment status and runtime health;
- current artifact/candidate status in a workbench (its own state files are
  authoritative);
- which files currently exist, their current contents.

Persist what cannot cheaply be reconstructed:
- non-obvious decisions and the rationale behind them;
- expensive observations (a finding that took a real investigation to
  produce, not something re-derivable by rerunning a cheap check);
- human/perceptual judgements worth keeping (something a person or an
  agent's perceptual review concluded, which a mechanical check cannot
  reproduce);
- provenance and licensing information for an asset;
- qualified/frozen evidence itself (see `candidate-evidence-pattern.md` and
  the `evidence-freeze` skill);
- durable limitations and workarounds (a capability confirmed absent or
  unreliable on this specific setup, and why);
- lessons that have repeatedly proven load-bearing across sessions.

Do not maintain multiple manually-synced copies of the same current fact —
if two places could both claim to say what's currently true, one of them
should instead point at the other, or at the authoritative source.

## Why this matters

A hand-maintained copy of derivable state goes stale silently — nothing
forces it to track the authoritative source, so it accumulates drift that
looks authoritative right up until it's wrong. A durable contract
(`CLAUDE.md`/`AGENTS.md`), a memory record, or a status doc that lists
"current" tool counts, file lists, or capability inventories is a standing
liability, not a convenience.

Conversely, failing to persist a genuinely expensive or judgement-heavy
conclusion means re-paying its cost every time it becomes relevant again —
or worse, silently re-deciding something already settled, possibly
differently the second time.

## Where this shows up

- **Durable contract vs. Prime**: a project's `CLAUDE.md` should state
  durable, load-bearing facts and invariants — not something Prime derives
  fresh each run (see `prime-contract.md`).
- **Memory vs. repository/runtime**: see `memory-placement.md` for the fuller
  boundary, which is this same rule applied specifically to what belongs in
  cross-session memory.
- **Evidence vs. narrative**: frozen evidence (a render, a measurement, a
  qualified candidate) is persisted because it is expensive to reproduce and
  because its value is in being a fixed historical reference point — not
  because everything worth knowing should be written down.
